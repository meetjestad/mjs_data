<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("lib_greenroof_db.php");
require_once 'lib_greenroof_func.php';

$fpRaw = null;
$fpCalc = null;
$iDeb = 0;


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
if ($iDeb > 0) printf("dtStart='$dtStart'\n");

$sQuery1 = "SELECT timestamp, station_id, temperature, extra FROM sensors_measurement WHERE timestamp > '$dtStart' AND station_id = $iStation_id ORDER BY timestamp DESC LIMIT $iNumber";

$aaResult1 = queryr($sQuery1);


$sRawFile = sprintf("../lst/mjs_greenroof_%04d_ra_%s.lst", $iStation_id, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
if ($iDeb > 0) fprintf($fpRaw, "-- %s\n", $sQuery1);
fprintf($fpRaw, "# UTC-timestamp	Station-id	Ambient-temperature	Extra\n");

$sCalcFile = sprintf("../lst/mjs_greenroof_%04d_ca_%s.lst", $iStation_id, $sPer);
$fpCalc = fopen($sCalcFile, "w");
if ($fpCalc == null) {
    exit("cannot write $sCalcFile, abort\n");
}
fprintf($fpCalc, "# Local-timestamp	Station-id	Ambient-temperature	Soil-humidity	Soil-temperature\n");


$aCal = print_calibration($sStation_id);
if ($iDeb > 0) {
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
        $sLocTimestamp = date("Y-m-d H:i:s", $iUnixtime);
        $sLocTimestamp = str_replace(" ", ".", $sLocTimestamp);
        if ($iDeb > 1) printf("UtcTimestamp=$sUtcTimestamp Unixtime=$iUnixtime LocTimestamp=$sLocTimestamp\n");

        $rSoilM = "-999.";
        $rSoilT = "-999.";
        $aExtra = explode(',', $sExtra);
        $nExtra = count($aExtra);
        if ($sExtra == "") { 
            $nExtra = 0;
        }
        if ($nExtra < 1) {
            if ($iDeb > 1) printf("row %d: aantal extra velden: %d\n", $iRow + 1, $nExtra);
            $sSoilM = "?";
            $sSoilT = "?";
	} else if ($nExtra < 2) {
            if ($iDeb > 1) printf("row %d: aantal extra velden: %d\n", $iRow + 1, $nExtra);
            $rSoilM = $aExtra[$aCal['soilM']];
            $fSoilM = (float) $rSoilM;
            $cSoilM = $fSoilM * $aCal['soilMa'] + $aCal['soilMb'];
            $sSoilM = sprintf("%.1f", $cSoilM);
            $sSoilT = "?";
        } else {
            $rSoilM = $aExtra[$aCal['soilM']];
            $fSoilM = (float) $rSoilM;
            $cSoilM = $fSoilM * $aCal['soilMa'] + $aCal['soilMb'];
            $sSoilM = sprintf("%.1f", $cSoilM);
            $rSoilT = $aExtra[$aCal['soilT']];
            $fSoilT = (float) $rSoilT;
            $cSoilT = $fSoilT * $aCal['soilTa'] + $aCal['soilTb'];
            $sSoilT = sprintf("%.1f", $cSoilT);
        }
        if ($iDeb > 0) printf("humi: raw=%s graph=%s   ", $rSoilM, $sSoilM);
        if ($iDeb > 0) printf("temp: raw=%s graph=%s\n", $rSoilT, $sSoilT);

        fprintf($fpCalc,  "%s	%s	%s	%s	%s\n", 
                $sLocTimestamp, $sStationId, $sTemp, $sSoilM, $sSoilT);
    }

    $iRow++;
}

fClose($fpRaw);
fClose($fpCalc);


?>
