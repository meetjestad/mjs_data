<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("libmjsdb.php");
require_once ("libdewp.php");
require_once ("libmath.php");

$iDeb = 0;

$fpRaw = null;
$fpCal = null;
$fpInt = null;


if ($argc < 3) {
    printf("usage: $argv[0] station_id period\n");
    exit(1);
} 

$sStation_id = $argv[1];
$iStation_id = (int) $sStation_id;
$sStation_id = sprintf("%04d", $iStation_id);

$sPer = $argv[2];
if ($sPer == '01d') {
    $uStartTime = time() - 1 * 86400;
    $nSamples = 96;
    $nIntPer = 5 * 60;
} else if ($sPer == '04d') {
    $uStartTime = time() - 4 * 86400;
    $nSamples = 384;
    $nIntPer = 15 * 60;
} else if ($sPer == '02w') {
    $nSamples = 1344;
    $uStartTime = time() - 14 * 86400;
    $nIntPer = 60 * 60;
} else if ($sPer == '02m') {
    $nSamples = 5856;
    $uStartTime = time() - 61 * 86400;
    $nIntPer = 240 * 60;
} else if ($sPer == '06m') {
    $nSamples = 17520;
    $uStartTime = time() - 183 * 86400;
    $nIntPer = 720 * 60;
} else if ($sPer == '02y') {
    $nSamples = 70128;
    $uStartTime = time() - 731 * 86400;
    $nIntPer = 2880 * 60;
} else {
    $nSamples = 96;
    $uStartTime = time() - 1 * 86400;
}
$dtStart = gmdate("Y-m-d H:i:s", $uStartTime);
#printf("nSamples=$nSamples\n");

$sQuery1 = "SELECT timestamp, station_id, battery, supply, extra  FROM sensors_measurement  WHERE station_id = $iStation_id  AND timestamp > '$dtStart' AND battery IS NOT NULL AND battery < 4.5 AND battery > 2.5  ORDER BY timestamp DESC  LIMIT $nSamples";
$sQuery1 = "SELECT timestamp, station_id, temperature, humidity  FROM sensors_measurement  WHERE station_id = $iStation_id  AND timestamp > '$dtStart'  ORDER BY timestamp DESC  LIMIT $nSamples";
#printf("sQuery1='$sQuery1'\n");

$aaResult1 = queryr($sQuery1);

$sRawFile = sprintf("../lst/mjs_fhum2_%04d_raw_%s.lst", $iStation_id, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
#fprintf($fpRaw, "-- %s\n", $sQuery1);

$sCalFile = sprintf("../lst/mjs_fhum2_%04d_cal_%s.lst", $iStation_id, $sPer);
$fpCal = fopen($sCalFile, "w");
if ($fpCal == null) {
    exit("cannot write $sCalFile, abort\n");
}

$sIntFile = sprintf("../lst/mjs_fhum2_%04d_int_%s.lst", $iStation_id, $sPer);
$fpInt = fopen($sIntFile, "w");
if ($fpInt == null) {
    exit("cannot write $sIntFile, abort\n");
}


$iRow=0;
foreach ($aaResult1 as $aRow) {
    $nCols = sizeof($aRow);
    if ($nCols < 3) {
        printf("Error: row=$iRow cols=$nCols\n");
    } else {
        $sUtcTimestamp = $aRow[0];
        $sStationId = $aRow[1];
        $sTemp = $aRow[2];
        $sHumi = $aRow[3];
        fprintf($fpRaw, "%s	%s	%s	%s\n", 
        $sUtcTimestamp, $sStationId, $sTemp, $sHumi);

        date_default_timezone_set('UTC');
        $iUnixtime = strtotime($sUtcTimestamp);
        date_default_timezone_set('Europe/Amsterdam');
        $sLocTimestamp = date("Y-m-d.H:i:s", $iUnixtime);
        #printf("UtcTimestamp=$sUtcTimestamp Unixtime=$iUnixtime LocTimestamp=$sLocTimestamp\n");

        $fTemp = (float) $sTemp;
        $sTemp = sprintf("%.2f", $fTemp);
        $fHumi = (float) $sHumi;
        if ($fHumi < 10) {
            $sDewp = "?";
        } else {
            $fDewp = TempRelHumi2dewp($fTemp, $fHumi);
            $sDewp = sprintf("%.2f", $fDewp);
            $sHumi = sprintf("%.2f", $fHumi);
        }

        # Note: this runs back in time: UnixtimeOld > Unixtime !
        if ($iRow > 0) {
            if ($iDeb > 0) printf("Row=$iRow UnixtimeOld=$iUnixtimeOld Unixtime=$iUnixtime\n");
            for ($iTime5 = floorn($iUnixtimeOld, $nIntPer); $iTime5 >= ceiln($iUnixtime, $nIntPer); $iTime5 -= $nIntPer) {
                $sLocTimestamp5 = date("Y-m-d.H:i:s", $iTime5);
                $fWeightOld  = ($iUnixtime-$iTime5) / ($iUnixtime-$iUnixtimeOld);
                $fWeightNew = ($iTime5-$iUnixtimeOld) / ($iUnixtime-$iUnixtimeOld);
                $fTemp5 = $fTempOld * $fWeightOld + $fTemp * $fWeightNew;
                $fHumi5 = $fHumiOld * $fWeightOld + $fHumi * $fWeightNew;
                $fDewp5 = $fDewpOld * $fWeightOld + $fDewp * $fWeightNew;
                if ($iDeb > 1) {
                    printf("UnixtimeOld=$iUnixtimeOld Time=$iTime5 Unixtime=$iUnixtime\n");
                    printf("WeightOld=%.3f WeightNew=%.3f\n", $fWeightOld, $fWeightNew);
                    printf("TempOld=%.2f Temp5=%.2f Temp=%.2f\n", $fTempOld, $fTemp5, $fTemp);
                    printf("HumiOld=%.2f Humi5=%.2f Humi=%.2f\n", $fHumiOld, $fHumi5, $fHumi);
                    printf("DewpOld=%.2f Dewp5=%.2f Dewp=%.2f\n", $fDewpOld, $fDewp5, $fDewp);
                }

                if ($iDeb > 0) printf("%d	%s	%.2f	%.2f	%.2f\n\n", $iTime5, $sStationId, $fTemp5, $fHumi5, $fDewp5);

                fprintf($fpInt, "%s	%d	%s	%.2f	%.2f	%.2f\n", $sLocTimestamp5, $iTime5, $sStationId, $fTemp5, $fHumi5, $fDewp5);
            }
        }
        fprintf($fpCal,  "%s	%d	%s	%s	%s	%s\n", 
                $sLocTimestamp, $iUnixtime, $sStationId, $sTemp, $sHumi, $sDewp);

        $iUnixtimeOld = $iUnixtime;
        $fTempOld = $fTemp;
        $fHumiOld = $fHumi;
        $fDewpOld = $fDewp;
    }

    $iRow++;
}


fClose($fpRaw);
fClose($fpCal);
fClose($fpInt);


?>
