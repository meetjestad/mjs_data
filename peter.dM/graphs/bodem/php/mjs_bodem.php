<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("lib_bodem_db.php");
require_once 'lib_bodem_func.php';

$fpRaw = null;
$fpCalc = null;
$lDeb = 0;


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
    $iNumber = 1 * 96;
} else if ($sPer == '04d') {
    $uStartTime = time() - 4 * 86400;
    $iNumber = 4 * 96;
} else if ($sPer == '02w') {
    $uStartTime = time() - 14 * 86400;
    $iNumber = 14 * 96;
} else if ($sPer == '02m') {
    $uStartTime = time() - 61 * 86400;
    $iNumber = 61 * 96;
} else if ($sPer == '06m') {
    $uStartTime = time() - 182 * 86400;
    $iNumber = 182 * 96;
} else if ($sPer == '02y') {
    $uStartTime = time() - 731 * 86400;
    $iNumber = 731 * 96;
} else {
    $uStartTime = time() - 1 * 86400;
    $iNumber = 1 * 96;
}
$dtStart = gmdate("Y-m-d H:i:s", $uStartTime);
$dtEpoch = '2021-12-14 18:00:00';
if ($dtStart < $dtEpoch) $dtStart = $dtEpoch;
if ($lDeb > 0) printf("dtStart='$dtStart'\n");

$sQuery1 = "SELECT timestamp, station_id, temperature, extra FROM sensors_measurement WHERE timestamp > '$dtStart' AND station_id = $iStation_id ORDER BY timestamp DESC LIMIT $iNumber";

$aaResult1 = queryr($sQuery1);

$sRawFile = sprintf("../lst/mjs_bodem_%04d_ra_%s.lst", $iStation_id, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
fprintf($fpRaw, "#UTCtimestamp	StationId	Temperature	Extra\n");
if ($lDeb > 0) fprintf($fpRaw, "-- %s\n", $sQuery1);

$sCalcFile = sprintf("../lst/mjs_bodem_%04d_ca_%s.lst", $iStation_id, $sPer);
$fpCalc = fopen($sCalcFile, "w");
if ($fpCalc == null) {
    exit("cannot write $sCalcFile, abort\n");
}
fprintf($fpCalc, "#LocTimestamp	StationId	Temperature	SoilM1	SoilT1	SoilM2	SoilT2\n");

$aCal = print_calibration($sStation_id);
if ($lDeb > 0) {
    printf("Station_id=%s, Cal=\n", $sStation_id);
    print_r($aCal);
    printf("\n");
};


$iRow=0;
foreach ($aaResult1 as $aRow) {
    $nCols = sizeof($aRow);
    if ($nCols < 4) {
        printf("Error: row=$iRow cols=$nCols\n");
    } else {
        $sUtcTimestamp = $aRow[0];
        $sStationId = $aRow[1];
        $sTemp  = $aRow[2];
        $sExtra = $aRow[3];
        fprintf($fpRaw, "%s	%s	%s	%s\n", 
            $sUtcTimestamp, $sStationId, $sTemp, $sExtra);

        date_default_timezone_set('UTC');
        $iUnixtime = strtotime($sUtcTimestamp);
        date_default_timezone_set('Europe/Amsterdam');
        $sLocTimestamp = date("Y-m-d.H:i:s", $iUnixtime);
        if ($lDeb > 1) printf("UtcTimestamp=$sUtcTimestamp Unixtime=$iUnixtime LocTimestamp=$sLocTimestamp\n");

        $rSoilM1 = "-999.";
        $rSoilT1 = "-999.";
        $rSoilM2 = "-999.";
        $rSoilT2 = "-999.";
        $sSoilM1 = "?";
        $sSoilT1 = "?";
        $sSoilM2 = "?";
        $sSoilT2 = "?";
        $aExtra = explode(',', $sExtra);
        $nExtra = count($aExtra);
        if ($sExtra == "") { 
            $nExtra = 0;
	}

        if ($lDeb > 1) printf("row %d: aantal extra velden: %d\n", $iRow + 1, $nExtra);
        if ($nExtra >= 13) {   # bodemvocht: SoilM1, SoilT1, SoilM2, SoulT2, solar
            $rSoilM1 = $aExtra[$aCal['soilM1']];   # [9]
            $fSoilM1 = (float) $rSoilM1;
            $cSoilM1 = $fSoilM1 * $aCal['soilM1a'] + $aCal['soilM1b'];
            $sSoilM1 = sprintf("%.1f", $cSoilM1);
            $rSoilT1 = $aExtra[$aCal['soilT1']];   # [10]
            $fSoilT1 = (float) $rSoilT1;
            $cSoilT1 = $fSoilT1 * $aCal['soilT1a'] + $aCal['soilT1b'];
            $sSoilT1 = sprintf("%.1f", $cSoilT1);
            $rSoilM2 = $aExtra[$aCal['soilM2']];   # [11]
            $fSoilM2 = (float) $rSoilM2;
            $cSoilM2 = $fSoilM2 * $aCal['soilM2a'] + $aCal['soilM2b'];
            $sSoilM2 = sprintf("%.1f", $cSoilM2);
            $rSoilT2 = $aExtra[$aCal['soilT2']];   # [12]
            $fSoilT2 = (float) $rSoilT2;
            $cSoilT2 = $fSoilT2 * $aCal['soilT2a'] + $aCal['soilT2b'];
            $sSoilT2 = sprintf("%.1f", $cSoilT2);
        } else if ($nExtra >= 11) {   # enkele bodemvocht/groen dak: SoilM1, SoilT1, solar
            $rSoilM1 = $aExtra[$aCal['soilM1']];   # [9]
            $fSoilM1 = (float) $rSoilM1;
            $cSoilM1 = $fSoilM1 * $aCal['soilM1a'] + $aCal['soilM1b'];
            $sSoilM1 = sprintf("%.1f", $cSoilM1);
            $rSoilT1 = $aExtra[$aCal['soilT1']];   # [10]
            $fSoilT1 = (float) $rSoilT1;
            $cSoilT1 = $fSoilT1 * $aCal['soilT1a'] + $aCal['soilT1b'];
            $sSoilT1 = sprintf("%.1f", $cSoilT1);
            #$sSoilM2 = "?";
	    #$sSoilT2 = "?";
	}

        if ($lDeb > 0) {
            printf("humi1: %s => %s   ", $rSoilM1, $sSoilM1);
            printf("temp1: %s => %s   ", $rSoilT1, $sSoilT1);
            printf("humi2: %s => %s   ", $rSoilM2, $sSoilM2);
            printf("temp2: %s => %s\n",  $rSoilT2, $sSoilT2);
        }

        fprintf($fpCalc,  "%s	%s	%s	%s	%s	%s	%s\n", 
                $sLocTimestamp, $sStationId, $sTemp, $sSoilM1, $sSoilT1, $sSoilM2, $sSoilT2);
    }

    $iRow++;
}

fClose($fpRaw);
fClose($fpCalc);


?>
