<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("libmath.php");
require_once ("libmjsdb.php");

$lDeb = 0;

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
    $nSamples = 96;
} else if ($sPer == '04d') {
    $nSamples = 384;
} else if ($sPer == '02w') {
    $nSamples = 1344;
} else if ($sPer == '02m') {
    $nSamples = 5856;
} else if ($sPer == '06m') {
    $nSamples = 17520;
} else if ($sPer == '02y') {
    $nSamples = 70128;
} else {
    $nSamples = 96;
}
$nIntPer = 900;
if ($lDeb > 0) printf("nSamples=$nSamples IntPer=$nIntPer\n"); 


$sQuery1 = "SELECT timestamp, station_id, pm2_5  FROM sensors_measurement  WHERE station_id = $iStation_id  AND pm2_5 < 1000. ORDER BY timestamp DESC  LIMIT $nSamples";
#printf("sQuery1='$sQuery1'\n");

$aaResult1 = queryr($sQuery1);


$sRawFile = sprintf("../lst/mjs_pm_%04d_raw_%s.lst", $iStation_id, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
#fprintf($fpRaw, "-- %s\n", $sQuery1);

$sCalFile = sprintf("../lst/mjs_pm_%04d_cal_%s.lst", $iStation_id, $sPer);
$fpCal = fopen($sCalFile, "w");
if ($fpCal == null) {
    exit("cannot write $sCalFile, abort\n");
}

$sIntFile = sprintf("../lst/mjs_pm_%04d_int_%s.lst", $iStation_id, $sPer);
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
	$sPM25 = $aRow[2];
	$fPM25 = (float) $sPM25;
        fprintf($fpRaw, "%s	%s	%6s\n", $sUtcTimestamp, $sStationId, $sPM25);

        date_default_timezone_set('UTC');
        $uEpoch = strtotime($sUtcTimestamp);
        date_default_timezone_set('Europe/Amsterdam');
        $sLocTimestamp = date("Y-m-d.H:i:s", $uEpoch);
        #printf("UtcTimestamp=$sUtcTimestamp Unixtime=$uEpoch LocTimestamp=$sLocTimestamp\n");

        fprintf($fpCal,  "%s	%s	%6s\n", $sLocTimestamp, $sStationId, $sPM25);

        # Note: this runs back in time: UnixtimeOld > Unixtime !
        if ($iRow > 0) {
            #fprintf($fpInt, "%s	%d	%s	%.2f\n", $sLocTimestamp, $uEpoch, $sStationId, $fPM25);
	#} else {
            if ($lDeb > 0) printf("Row=$iRow UnixtimeOld=$uEpochOld Unixtime=$uEpoch\n");
            for ($uTime5 = floorn($uEpochOld, $nIntPer); $uTime5 >= ceiln($uEpoch, $nIntPer); $uTime5 -= $nIntPer) {
                $sLocTimestamp5 = date("Y-m-d.H:i:s", $uTime5);
                if ($uEpoch == $uEpochOld) {
                    $fWeightOld = 0.5;
                    $fWeightNew = 0.5;
                } else {
                    $fWeightOld  = ($uEpoch-$uTime5) / ($uEpoch-$uEpochOld);
                    $fWeightNew = ($uTime5-$uEpochOld) / ($uEpoch-$uEpochOld);
	        }
                $fPM25e = $fPM25old * $fWeightOld + $fPM25 * $fWeightNew;
                if ($lDeb > 1) {
                    printf("UnixtimeOld=$uEpochOld Time=$uTime5 Unixtime=$uEpoch\n");
                    printf("WeightOld=%.3f WeightNew=%.3f\n", $fWeightOld, $fWeightNew);
                    printf("PM25old=%.2f PM25e=%.2f PM25=%.2f\n", $fPM25old, $fPM25e, $fPM25);
                }

                if ($lDeb > 0) printf("%d	%s	%6.2f\n\n", $uTime5, $sStationId, $fPM25e);

                fprintf($fpInt, "%s	%d	%s	%6.2f\n", $sLocTimestamp5, $uTime5, $sStationId, $fPM25e);
            }
        }
        #fprintf($fpCal,  "%s	%d	%s	%s\n", $sLocTimestamp, $uEpoch, $sStationId, $sPM25);

        $uEpochOld = $uEpoch;
        $fPM25old = $fPM25;
    }

    $iRow++;
}

fClose($fpRaw);
fClose($fpCal);
fClose($fpInt);


?>
