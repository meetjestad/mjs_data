<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("lib_boom_db.php");
// require_once 'lib_boom_func.php';

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

# TO DO: Fix ignore measurements before start date (23 June 12h) using json
$sQuery1 = "SELECT timestamp, station_id, temperature, extra FROM sensors_measurement WHERE timestamp > '$dtStart' AND timestamp > '2022-06-23 12:00:00' AND station_id = $iStation_id ORDER BY timestamp DESC LIMIT $iNumber";

$aaResult1 = queryr($sQuery1);

$sRawFile = sprintf("../lst/mjs_boom_%04d_ra_%s.lst", $iStation_id, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
if ($lDeb > 0) fprintf($fpRaw, "# %s\n", $sQuery1);
fprintf($fpRaw, "# UtcTimeStamp	StationId	Temperature	Extra\n");

$sCalcFile = sprintf("../lst/mjs_boom_%04d_ca_%s.lst", $iStation_id, $sPer);
$fpCalc = fopen($sCalcFile, "w");
if ($fpCalc == null) {
    exit("cannot write $sCalcFile, abort\n");
}
fprintf($fpCalc, "# LocTimeStamp	StationId	Temperature	DiameterADC	DiameterCalibrated\n");


$aaCalc = array();
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

        $rDiameter = "-999.";
        $aExtra = explode(',', $sExtra);
        $nExtra = count($aExtra);
        if ($sExtra == "") { 
            $nExtra = 0;
        }
        if ($nExtra < 1) {
            if ($lDeb > 1) printf("row %d: aantal extra velden: %d\n", $iRow + 1, $nExtra);
            $sDiameter = "?";
        } else {
            $rDiameter = $aExtra[0];
            $fDiameter = (float) $rDiameter;
            #if ($fDiameter == 0.0 or $fDiameter == 1023.0) {
                #$sDiameter = '?';
            #} else {
                #$cDiameter = $fDiameter * 100. / 1024.;    // potentiometer length 100 mm, 1024 bit full-scale
                #$sDiameter = sprintf("%.1f", $cDiameter);
            #}
        }
        if ($lDeb > 0) {
            printf("dikte: raw=%s graph=%s   ", $rDiameter, $sDiameter);
        }

        //fprintf($fpCalc,  "%s	%s	%s	%s\n", 
		//$sLocTimestamp, $sStationId, $sTemp, $sDiameter);
	$aCalc1 = array('timestamp' =>$sLocTimestamp, 'station' => $sStationId, 'temp' => $sTemp, 'dikte' => $fDiameter);
        $aaCalc[] = $aCalc1;
    }

    $iRow++;
}

/*
$fAvgDiameter = 0.;
$jRow = 0;
foreach ($aaCalc as $aCalc2) {
            $fDiameter = $aCalc2['dikte'];
        if ($fDiameter != 0.0 and $fDiameter != 1023.0) {
            $fAvgDiameter += $fDiameter;   // expressed in ADC units
            $jRow += 1;
            }
}
$fAvgDiameter /= $jRow;
*/

foreach ($aaCalc as $aCalc3) {
    $sLocTimestamp = $aCalc3['timestamp'];
    $sStationId = $aCalc3['station'];
    $sTemp = $aCalc3['temp'];
    $sDiameter = $aCalc3['dikte'];
    if ($sDiameter == '?') {
        $sDiameterC = '?';
    } else {
        // $fDiameter = $sDiameter - $fAvgDiameter;   // expressed in ADC units
        $fDiameter = $sDiameter;   // expressed in ADC units
	$cDiameter = 143.46 - 3.1442 * (($fDiameter/1024.) * 10. + 28.4);
        $sDiameterC = sprintf("%f", $cDiameter);
    }
        fprintf($fpCalc,  "%s	%s	%s	%s	%s\n", 
                $sLocTimestamp, $sStationId, $sTemp, $sDiameter, $sDiameterC);
}

fClose($fpRaw);
fClose($fpCalc);


?>
