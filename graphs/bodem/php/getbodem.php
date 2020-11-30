<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("libmjsdb.php");

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
} else {
    $uStartTime = time() - 1 * 86400;
}
$dtStart = gmdate("Y-m-d H:i:s", $uStartTime);
#printf("dtStart='$dtStart'\n");

$sQuery1 = "SELECT timestamp, station_id, extra FROM sensors_measurement WHERE station_id = $iStation_id AND timestamp >= '$dtStart' ORDER BY timestamp ASC";

$aaResult1 = queryr($sQuery1);

$sRawFile = sprintf("../plt/mjs_bodem_%04d_%s.lst", $iStation_id, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
#fprintf($fpRaw, "-- %s\n", $sQuery1);

$sCapFile = sprintf("../plt/mjs_bodem_%04d_c_%s.lst", $iStation_id, $sPer);
$fpCap = fopen($sCapFile, "w");
if ($fpCap == null) {
    exit("cannot write $sCapFile, abort\n");
}

$sTempFile = sprintf("../plt/mjs_bodem_%04d_t_%s.lst", $iStation_id, $sPer);
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
        $sLocTimestamp = date("Y-m-d H:i:s", $iUnixtime);
        $sLocTimestamp = str_replace(" ", ".", $sLocTimestamp);

        $aExtra = explode(',', $sExtra);
    # bevat: Cnc, Tnc, Cref, Tref, C10, T10, C40, T40, C80, T80, C120, T120
        if (count($aExtra) >= 12 && $aExtra[0] != 0) {
            $fNref  = $aExtra[2]   - $aExtra[0];    # count for 39 picoFarad
            if ($fNref == 0.) {
                $fC10 = null;
                $fC40 = null;
                $fC80 = null;
                $fC120 = null;
            } else {
                $fC10   = ($aExtra[4]  - $aExtra[0]) / $fNref * 39000.;
                $fC40   = ($aExtra[6]  - $aExtra[0]) / $fNref * 39000.;
                $fC80   = ($aExtra[8]  - $aExtra[0]) / $fNref * 39000.;
                $fC120  = ($aExtra[10] - $aExtra[0]) / $fNref * 39000.;
            }
            $fTref  = ($aExtra[3]  / 4.) - 20.;
            $fT10   = ($aExtra[5]  / 4.) - 20.;
            $fT40   = ($aExtra[7]  / 4.) - 20.;
            $fT80   = ($aExtra[9]  / 4.) - 20.;
            $fT120  = ($aExtra[11] / 4.) - 20.;

            fprintf($fpCap,  "%s	%s	%.0f	%.0f	%.0f	%.0f	null\n", $sLocTimestamp, $sStationId, $fC10, $fC40, $fC80, $fC120);
    
	    fprintf($fpTemp, "%s	%s	%.2f	%.2f	%.2f	%.2f	%.2f	null\n", $sLocTimestamp, $sStationId, $fTref, $fT10, $fT40, $fT80, $fT120);
	}
    }

    $iRow++;
}

fClose($fpRaw);
fClose($fpCap);
fClose($fpTemp);

?>
