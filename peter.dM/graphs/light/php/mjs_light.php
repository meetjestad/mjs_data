<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("liblightdb.php");

$fpRaw = null;
$fpLight = null;


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

$sQuery1 = "SELECT timestamp, station_id, lux FROM sensors_measurement WHERE station_id = $iStation_id AND timestamp >= '$dtStart' ORDER BY timestamp ASC";

$aaResult1 = queryr($sQuery1);

$sRawFile = sprintf("../lst/mjs_light_%04d_%s.lst", $iStation_id, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
#fprintf($fpRaw, "-- %s\n", $sQuery1);

$sLightFile = sprintf("../lst/mjs_light_%04d_sb_%s.lst", $iStation_id, $sPer);
$fpLight = fopen($sLightFile, "w");
if ($fpLight == null) {
    exit("cannot write $sLightFile, abort\n");
}


$iRow=0;
foreach ($aaResult1 as $aRow) {
    $nCols = sizeof($aRow);
    if ($nCols < 3) {
        printf("Error: row=$iRow cols=$nCols\n");
    } else {
        $sUtcTimestamp = $aRow[0];
        $sStationId = $aRow[1];
        $sLight = $aRow[2];
        fprintf($fpRaw, "%s	%s	%s\n", 
	    $sUtcTimestamp, $sStationId, $sLight);

        date_default_timezone_set('UTC');
        $iUnixtime = strtotime($sUtcTimestamp);
        date_default_timezone_set('Europe/Amsterdam');
        $sLocTimestamp = date("Y-m-d H:i:s", $iUnixtime);
	$sLocTimestamp = str_replace(" ", ".", $sLocTimestamp);
	#printf("UtcTimestamp=$sUtcTimestamp Unixtime=$iUnixtime LocTimestamp=$sLocTimestamp\n");

	#$sLight = fmt($sLight*1000, 0);

	$iLight  = (int) $sLight;

        fprintf($fpLight,  "%s	%s	%s\n", 
		$sLocTimestamp, $sStationId, $sLight);
    }

    $iRow++;
}

fClose($fpRaw);
fClose($fpLight);


# ============================================================================================================

/*
function fmt($sStr, $d) {
    if (((int) $sStr) > 0x7F00) {
        $retval = '?';
        printf("fmt('$sStr',$d)='$retval'\n");
    } else {
        switch($d){
            case 2:  $retval = sprintf("%.2f", $sStr); break;
            default: $retval = sprintf("%.0f", $sStr); break;
        }
    }
    #printf("fmt('$sStr',$d)=$retval\n");
    return $retval;
}
*/

?>
