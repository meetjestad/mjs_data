<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("libmjsdb.php");

if ($argc < 3) {
    exit("usage: $argv[0] station_id period [endtime YYYY-MM-DD]\n");
} 

$sStation_id = $argv[1];
$iStation_id = (int) $sStation_id;
$sStation_id = sprintf("%04d", $iStation_id);

if ($argc >= 4) {
    $dtEinde = $argv[3] . " 23:59:59 UTC";
} else {
    $dtEinde = gmdate("Y-m-d H:i:s", time());
}
$uEinde = strtotime($dtEinde);

$sPer = $argv[2];
if ($sPer == '04d') {
    $uStartTime = $uEinde - 4 * 86400;
    $nSamples = 384;
} else if ($sPer == '02w') {
    $uStartTime = $uEinde - 14 * 86400;
    $nSamples = 1344;
} else if ($sPer == '02m') {
    $uStartTime = $uEinde - 61 * 86400;
    $nSamples = 5856;
} else if ($sPer == '06m') {
    $uStartTime = $uEinde - 182 * 86400;
    $nSamples = 17520;
} else {
    $uStartTime = $uEinde - 1 * 86400;
    $nSamples = 96;
}
$dtStart = gmdate("Y-m-d H:i:s", $uStartTime);
printf("dtStart='$dtStart' dtEinde='$dtEinde'\n");

$sQuery1 = "SELECT timestamp, station_id, extra FROM sensors_measurement WHERE station_id = $iStation_id AND timestamp <= '$dtEinde' ORDER BY timestamp DESC limit $nSamples";
$sQuery1 = "SELECT timestamp, station_id, extra FROM sensors_measurement WHERE station_id = $iStation_id AND timestamp >= '$dtStart' AND timestamp <= '$dtEinde' ORDER BY timestamp DESC";
printf("Query1='$sQuery1'\n");

$aaResult1 = queryr($sQuery1);

$sRawFile = sprintf("../lst/mjs_boom_%04d_%s.lst", $iStation_id, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
#fprintf($fpRaw, "-- %s\n", $sQuery1);

$sCapFile = sprintf("../lst/mjs_boom_%04d_c_%s.lst", $iStation_id, $sPer);
$fpCap = fopen($sCapFile, "w");
if ($fpCap == null) {
    exit("cannot write $sCapFile, abort\n");
}

$sTempFile = sprintf("../lst/mjs_boom_%04d_t_%s.lst", $iStation_id, $sPer);
$fpTemp = fopen($sTempFile, "w");
if ($fpTemp == null) {
    exit("cannot write $sTempFile, abort\n");
}

$iRow=0;
foreach ($aaResult1 as $aRow) {
    $nCols = sizeof($aRow);
    if ($nCols < 3) {
        printf("Error: row=$iRow cols=$nCols\n");
    } else {
        $sUtcTimestamp = $aRow[0];
        $sStationId = $aRow[1];
        $sExtra = $aRow[2];
        fprintf($fpRaw, "%s	%s	%s\n", $sUtcTimestamp, $sStationId, $sExtra);

        date_default_timezone_set('UTC');
        $iUnixtime = strtotime($sUtcTimestamp);
        date_default_timezone_set('Europe/Amsterdam');
        $sLocTimestamp = date("Y-m-d.H:i:s", $iUnixtime);

        $aExtra = explode(',', $sExtra);
        # bevat: M10, T10, M40, T40, ???
        if (count($aExtra) >= 4) {
            $fM10   = $aExtra[0];
            $fM40   = $aExtra[2];
            $fT10   = $aExtra[1];
            $fT40   = $aExtra[3];

            fprintf($fpCap,  "%s	%s	%.0f	%.0f\n", $sLocTimestamp, $sStationId, $fM10, $fM40);
	    fprintf($fpTemp, "%s	%s	%.2f	%.2f\n", $sLocTimestamp, $sStationId, $fT10, $fT40);
	}
    }

    $iRow++;
}

fClose($fpRaw);
fClose($fpCap);
fClose($fpTemp);

?>
