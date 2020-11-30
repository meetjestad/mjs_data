<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("libtestdb.php");

if ($argc < 3) {
    exit("usage: $argv[0] station_id period\n");
} 

$sStation_id = $argv[1];
$iStation_id = (int) $sStation_id;
$sStation_id = sprintf("%04d", $iStation_id);

$sPer = $argv[2];
if ($sPer == '04d') {
    $uStartTime = time() - 4 * 86400;
} else if ($sPer == '02w') {
    $uStartTime = time() - 14 * 86400;
} else if ($sPer == '02m') {
    $uStartTime = time() - 60 * 86400;
} else if ($sPer == '06m') {
    $uStartTime = time() - 182 * 86400;
} else if ($sPer == '02y') {
    $uStartTime = time() - 730 * 86400;
} else if ($sPer == '06y') {
    $uStartTime = time() - 2192 * 86400;
} else {
    $uStartTime = time() - 1 * 86400;
}
$dtStart = gmdate("Y-m-d H:i:s", $uStartTime);
#printf("dtStart='$dtStart'\n");

$sQuery1 = "SELECT gmtijd, port, temp, humi FROM sens7021 WHERE port = $iStation_id AND gmtijd >= '$dtStart' ORDER BY gmtijd ASC";

$aaResult1 = queryr($sQuery1);

$sHumiFile = sprintf("../lst/balc_fhum_%04d_%s.lst", $iStation_id, $sPer);
$fpHumi = fopen($sHumiFile, "w");
if ($fpHumi == null) {
    exit("cannot write $sHumiFile, abort\n");
}

$iRow=0;
$iUnixtime = 0;
$iUnixtimeO = 0;
$sLocTimestamp = "0000-00-00 00:00:00";
$sLocTimestampO = "0000-00-00 00:00:00";
$sTemp = "null";
$sTempO = "null";
$fTemp = null;
$fTempO = null;
$sHumi = "null";
$sHumiO = "null";
$fHumi = null;
$fHumiO = null;
$fOffset = 0;
foreach ($aaResult1 as $aRow) {
    $nCols = sizeof($aRow);
    if ($nCols < 3) {
        printf("Error: row=$iRow cols=$nCols\n");
    } else {
        $sUtcTimestamp = $aRow[0];
        $sStationId = $aRow[1];
        $sTemp = $aRow[2];
        $sHumi = $aRow[3];

        date_default_timezone_set('UTC');
        $iUnixtime = strtotime($sUtcTimestamp);
        date_default_timezone_set('Europe/Amsterdam');
        $sLocTimestamp = date("Y-m-d H:i:s", $iUnixtime);
        $sLocTimestamp = str_replace(" ", ".", $sLocTimestamp);
        $fHumi = (float) $sHumi;
        $fHumiO = (float) $sHumiO;
        if ($iRow != 0) {
            if ($fHumi > 100.) { $fOffset = 0.; } else {
	    #else if ($fHumi < 30.) { $fOffset = 125.; } else {
                if ($fHumi - $fHumiO < -100. && $fOffset < 125.) { $fOffset += 125.; }
                if ($fHumi - $fHumiO >  100. && $fOffset > 0.)   { $fOffset -= 125.; }
            }
        }

        fprintf($fpHumi, "%s	%s	%10d	%10d	%s	%6.2f	%6.2f	%6.2f	%6.2f	%4.0f	%6.2f\n", 
        	$sLocTimestampO, $sLocTimestamp, $iUnixtimeO, $iUnixtime, $sStationId, $sTempO, $sTemp, $sHumi, $fHumi-$fHumiO, $fOffset, $fHumi+$fOffset);
        $iUnixtimeO = $iUnixtime;
        $sLocTimestampO = $sLocTimestamp;
        $sTempO = $sTemp;
        $sHumiO = $sHumi;
    }

    $iRow++;
}

fClose($fpHumi);

?>
