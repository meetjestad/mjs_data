<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("libmjsdb.php");

$fpRaw = null;
$fpLight = null;


if ($argc < 3) {
    printf("usage: $argv[0] station_id year\n");
    exit(1);
} 

$sStation_id = $argv[1];
$iStation_id = (int) $sStation_id;
$sStation_id = sprintf("%04d", $iStation_id);

$sEYear = $argv[2];
$iEYear = (int) $sEYear;
$iBYear = $iEYear - 1;
$sBYear = sprintf("%d", $iBYear);
$dtBegin = "$sBYear-12-31 17:00:00";
$dtEinde = "$sEYear-01-01 05:00:00";
$sPer = "12h";
printf("dtBegin='$dtBegin' dtEinde='$dtEinde'\n");

$sQuery1 = "SELECT timestamp, station_id, pm2_5 FROM sensors_measurement WHERE station_id = $iStation_id AND timestamp >= '$dtBegin'  AND timestamp <= '$dtEinde' ORDER BY timestamp ASC";

$aaResult1 = queryr($sQuery1);

$sRawFile = sprintf("../lst/mjs_pm_vw_%04d_%s_raw_%s.lst", $iStation_id, $sEYear, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
#fprintf($fpRaw, "-- %s\n", $sQuery1);

$sCkdFile = sprintf("../lst/mjs_pm_vw_%04d_%s_ckd_%s.lst", $iStation_id, $sEYear, $sPer);
$fpCkd = fopen($sCkdFile, "w");
if ($fpCkd == null) {
    exit("cannot write $sCkdFile, abort\n");
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
        fprintf($fpRaw, "%s	%s	%s\n", 
	    $sUtcTimestamp, $sStationId, $sPM25);

        date_default_timezone_set('UTC');
        $iUnixtime = strtotime($sUtcTimestamp);
	date_default_timezone_set('Europe/Amsterdam');
	if ($iEYear == 2021) $iUnixtime -= 366 * 24 * 60 * 60;
        $sLocTimestamp = date("Y-m-d.H:i:s", $iUnixtime);
	#$sLocTimestamp = str_replace(" ", ".", $sLocTimestamp);
	printf("UtcTimestamp=$sUtcTimestamp Unixtime=$iUnixtime LocTimestamp=$sLocTimestamp\n");

        fprintf($fpCkd,  "%s	%s	%s\n", 
		$sLocTimestamp, $sStationId, $sPM25);
    }

    $iRow++;
}

fClose($fpRaw);
fClose($fpCkd);


?>
