<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("libmjsdb.php");

if ($argc < 3) {
    printf("usage: $argv[0] station_id period\n");
    exit(1);
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
} else {
    $uStartTime = time() - 1 * 86400;
}
$dtStart = gmdate("Y-m-d H:i:s", $uStartTime);
#printf("dtStart='$dtStart'\n");

$sQuery1 = "SELECT timestamp, station_id, temperature, humidity, extra FROM sensors_measurement WHERE station_id = $iStation_id AND timestamp >= '$dtStart' ORDER BY timestamp ASC";

$aaResult1 = queryr($sQuery1);

$sRawFile = sprintf("../lst/mjs_mjs20_%04d_%s.lst", $iStation_id, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
#fprintf($fpRaw, "-- %s\n", $sQuery1);

$sTHfile = sprintf("../lst/mjs_mjs20_%04d_th_%s.lst", $iStation_id, $sPer);
$fpTH = fopen($sTHfile, "w");
if ($fpTH == null) {
    exit("cannot write $sTHfile, abort\n");
}

$sPMfile = sprintf("../lst/mjs_mjs20_%04d_pm_%s.lst", $iStation_id, $sPer);
$fpPM = fopen($sPMfile, "w");
if ($fpPM == null) {
    exit("cannot write $sPMfile, abort\n");
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
        $sExtra = $aRow[4];
        fprintf($fpRaw, "%s	%s	%s	%s	%s\n", $sUtcTimestamp, $sStationId, $sTemp, $sHumi, $sExtra);

        date_default_timezone_set('UTC');
        $iUnixtime = strtotime($sUtcTimestamp);
        date_default_timezone_set('Europe/Amsterdam');
        $sLocTimestamp = date("Y-m-d H:i:s", $iUnixtime);
        $sLocTimestamp = str_replace(" ", ".", $sLocTimestamp);

        $aExtra = explode(',', $sExtra);
        $nExtra = count($aExtra);
        if ($nExtra != 10) {
            printf("row %d: aantal extra velden: %d.\n", $iRow + 1, $nExtra);
        }
        # bevat: pm1.0, pm2.5, pm4.0, pm10.0, nc1.0, nc2.5, nc4.0, nc10.0, typ_size
        # opm.: nc0.5 wordt nog niet opgestuurd

        fprintf($fpTH,  "%s	%s	%.2f	%.2f\n", $sLocTimestamp, $sStationId, $sTemp, $sHumi);
        fprintf($fpPM,  "%s	%s	%.0f	%.0f	%.0f	%.0f	%.0f	%.0f	%.0f	%.0f	%.0f\n", 
        	$sLocTimestamp, $sStationId, $aExtra[0], $aExtra[1], $aExtra[2], $aExtra[3], $aExtra[4], $aExtra[5], $aExtra[6], $aExtra[7], $aExtra[8]);
    
    }

    $iRow++;
}

fClose($fpRaw);
fClose($fpPM);
fClose($fpTH);

?>
