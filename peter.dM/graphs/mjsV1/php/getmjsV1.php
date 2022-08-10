<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("libmjsdb.php");

$fpRaw = null;
$fpCal = null;
$fpPM = null;


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
    $iAantal = 1 * 96;
} else if ($sPer == '04d') {
    $uStartTime = time() - 4 * 86400;
    $iAantal = 4 * 96;
} else if ($sPer == '02w') {
    $uStartTime = time() - 14 * 86400;
    $iAantal = 14 * 96;
} else if ($sPer == '02m') {
    $uStartTime = time() - 61 * 86400;
    $iAantal = 61 * 96;
} else if ($sPer == '06m') {
    $uStartTime = time() - 182 * 86400;
    $iAantal = 182 * 96;
} else {
    $uStartTime = time() - 1 * 86400;
    $iAantal = 1 * 96;
}
$dtStart = gmdate("Y-m-d H:i:s", $uStartTime);
#printf("dtStart='$dtStart'\n");

#$sQuery1 = "SELECT timestamp, station_id, temperature, humidity, battery, supply, extra FROM sensors_measurement WHERE station_id = $iStation_id AND timestamp >= '$dtStart' ORDER BY timestamp DESC";
$sQuery1 = "SELECT timestamp, station_id, temperature, humidity, battery, supply, extra  FROM sensors_measurement  WHERE station_id = $iStation_id  ORDER BY timestamp DESC LIMIT $iAantal";

$aaResult1 = queryr($sQuery1);

$sRawFile = sprintf("../lst/mjs_mjsV1_%04d_%s.lst", $iStation_id, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
#fprintf($fpRaw, "-- %s\n", $sQuery1);

$sCalFile = sprintf("../lst/mjs_mjsV1_%04d_th_%s.lst", $iStation_id, $sPer);
$fpCal = fopen($sCalFile, "w");
if ($fpCal == null) {
    exit("cannot write $sCalFile, abort\n");
}

#$sPMfile = sprintf("../lst/mjs_mjsV1_%04d_pm_%s.lst", $iStation_id, $sPer);
#$fpPM = fopen($sPMfile, "w");
#if ($fpPM == null) {
    #exit("cannot write $sPMfile, abort\n");
#}

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
        $sBatt = $aRow[4];
        $sSupp = $aRow[5];
        #$sPM25 = $aRow[6];
        #$sPM10 = $aRow[7];
        $sExtra = $aRow[6];
        fprintf($fpRaw, "%s	%s	%s	%s	%s	%s	%s\n", 
	    $sUtcTimestamp, $sStationId, $sTemp, $sHumi, $sBatt, $sSupp, $sExtra);

        date_default_timezone_set('UTC');
        $iUnixtime = strtotime($sUtcTimestamp);
        date_default_timezone_set('Europe/Amsterdam');
        $sLocTimestamp = date("Y-m-d H:i:s", $iUnixtime);
        $sLocTimestamp = str_replace(" ", ".", $sLocTimestamp);

        $sSolar = "?";
	$sBatt = fmt($sBatt*1000, 0);
        $sSupp = fmt($sSupp*1000, 0);
        #$sPM25 = fmt($sPM25, 0);
        #$sPM10 = fmt($sPM10, 0);

        $aExtra = explode(',', $sExtra);
        $nExtra = count($aExtra);
        if ($sExtra == "") { $nExtra = 0; }
        if ($nExtra >= 11) {
            #printf("row %d: aantal extra velden: %d => PM + battery\n", $iRow + 1, $nExtra);
            $sSolar = $aExtra[9] . "0";
            $sBatt = $aExtra[10] . "0";
            #write_pm($fpPM, $sLocTimestamp, $sStationId, $aExtra);
        } else if ($nExtra >= 9) {
            #printf("row %d: aantal extra velden: %d => PM\n", $iRow + 1, $nExtra);
            #write_pm($fpPM, $sLocTimestamp, $sStationId, $aExtra);
        } else if ($nExtra >= 2) {
            #printf("row %d: aantal extra velden: %d => battery\n", $iRow + 1, $nExtra);
            $sSolar = $aExtra[0] . "0";
            $sBatt = $aExtra[1] . "0";
	}
	#printf("Solar=$sSolar Batt=$sBatt \n");

        fprintf($fpCal,  "%s	%s	%.2f	%.2f	%s	%s	%s\n", 
		$sLocTimestamp, $sStationId, $sTemp, $sHumi, $sSolar, $sBatt, $sSupp);
    
    }

    $iRow++;
}

fClose($fpRaw);
#fClose($fpPM);
fClose($fpCal);


# ============================================================================================================


#function write_pm($fpPM, $sLocTimestamp, $sStationId, $aExtra) {
    #if (count($aExtra) >= 9) {
        #$aExtra[1] = fmt($aExtra[1], 0);
        #$aExtra[3] = fmt($aExtra[3], 0);
        #printf("$aExtra\n");
        #if ($aExtra[0] + $aExtra[1] + $aExtra[2] + $aExtra[3] + $aExtra[4] + $aExtra[5] + $aExtra[6] + $aExtra[7] > 0) {
        #if ($aExtra[0] + $aExtra[1] + $aExtra[2] + $aExtra[3] + $aExtra[4] + $aExtra[5] + $aExtra[6] + $aExtra[7] == 0) {
            #printf("WARNING: $sLocTimestamp $sStationId:	extra[0:7] all 0\n");
        #} else {
            #fprintf($fpPM,  "%s	%s	%.0f	%s	%.0f	%s	%.0f	%.0f	%.0f	%.0f	%.0f\n", 
                #$sLocTimestamp, $sStationId, $aExtra[0], $aExtra[1], $aExtra[2], 
                #$aExtra[3], $aExtra[4], $aExtra[5], $aExtra[6], $aExtra[7], $aExtra[8]);
        #}
    #}
#}


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


?>
