<?php

# $Id: meetjestad.net/static/graphs/maint/php/mjs_repair.php $
# $Author: Peter Demmer for Meetjestad! $


error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("libmjsdb.php");


$fpRaw = null;
$fpMet = null;
$fpCal = null;

$iLastUpdated = time();

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
    $nSamples = 96;
} else if ($sPer == '04d') {
    $uStartTime = time() - 4 * 86400;
    $nSamples = 384;
} else if ($sPer == '02w') {
    $nSamples = 1344;
    $uStartTime = time() - 14 * 86400;
} else if ($sPer == '02m') {
    $nSamples = 5856;
    $uStartTime = time() - 61 * 86400;
} else if ($sPer == '06m') {
    $nSamples = 17520;
    $uStartTime = time() - 183 * 86400;
} else if ($sPer == '02y') {
    $nSamples = 70128;
    $uStartTime = time() - 731 * 86400;
} else {
    $nSamples = 96;
    $uStartTime = time() - 1 * 86400;
}
$dtStart = gmdate("Y-m-d H:i:s", $uStartTime);
#printf("nSamples=$nSamples\n");

$sQuery1 = "SELECT meas.timestamp, station_id, battery, supply, extra, message FROM sensors_measurement meas, sensors_message msg  WHERE meas.message_id = msg.id  AND station_id = $iStation_id  AND meas.timestamp > '$dtStart'  ORDER BY timestamp DESC  LIMIT $nSamples";
#printf("sQuery1='$sQuery1'\n");

$aaResult1 = queryr($sQuery1);

$sRawFile = sprintf("../lst/mjs_repair_%04d_raw_%s.lst", $iStation_id, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
#fprintf($fpRaw, "-- %s\n", $sQuery1);

$sCalFile = sprintf("../lst/mjs_repair_%04d_cal_%s.lst", $iStation_id, $sPer);
$fpCal = fopen($sCalFile, "w");
if ($fpCal == null) {
    exit("cannot write $sCalFile, abort\n");
}

$sMetFile = sprintf("../lst/mjs_repair_%04d_met_%s.json", $iStation_id, $sPer);
$fpMet = fopen($sMetFile, "w");
if ($fpMet == null) {
    exit("cannot write $sMetFile, abort\n");
}


$iRow=0;
$iValidBatt = 0;
$iF_cnt = -1;
$iF_cnt_0 = 0;
# in case no rows were found:
$iFirstTimeActive = -1;
$iLastTimeActive = -1;
$sFirstBatt = "";
$sLastBatt = "";
foreach ($aaResult1 as $aRow) {   # descending in time !
    $nCols = sizeof($aRow);
    if ($nCols < 3) {
        printf("Error: row=$iRow cols=$nCols\n");
    } else {
        $sUtcTimestamp = $aRow[0];
        $sStationId = $aRow[1];
        $sBatt = $aRow[2];   # e.g. 4.32
        $sSupp = $aRow[3];   # e.g. 3.29
        $sExtra = $aRow[4];
        $jsMessage = $aRow[5];
        #fprintf($fpRaw, "%s	%s	%s	%s	%s	%s\n", 
        #$sUtcTimestamp, $sStationId, $sBatt, $sSupp, $sExtra, $jsMessage);
        fprintf($fpRaw, "%s	%s	%s	%s	%s\n", 
        $sUtcTimestamp, $sStationId, $sBatt, $sSupp, $sExtra);

        date_default_timezone_set('UTC');
	$iUnixtime = strtotime($sUtcTimestamp);
	$iFirstTimeActive = $iUnixtime;
        $sFirstBatt  = $sBatt;
        date_default_timezone_set('Europe/Amsterdam');
        $sLocTimestamp = date("Y-m-d H:i:s", $iUnixtime);
	$sLocTimestamp = str_replace(" ", ".", $sLocTimestamp);
	if ($iRow == 0) {
            $iLastTimeActive = $iUnixtime;
            $sLastBatt = $sBatt;
        }
        #printf("UtcTimestamp=$sUtcTimestamp Unixtime=$iUnixtime LocTimestamp=$sLocTimestamp\n");

        $sSolar = "?";
        $sBatt = fmt($sBatt*1000, 0);   # 4320
        $sSupp = fmt($sSupp*1000, 0);   # 3290

        $aExtra = explode(',', $sExtra);
        $nExtra = count($aExtra);
        if ($sExtra == "") { $nExtra = 0; }
        if ($nExtra >= 10) {
            #printf("row %d: aantal extra velden: %d => PM + battery\n", $iRow + 1, $nExtra);
            $sSolar = $aExtra[9];
            #$sBatt = $aExtra[10] . "0";
        } else if ($nExtra < 9 && $nExtra >= 1) {
            #printf("row %d: aantal extra velden: %d => battery\n", $iRow + 1, $nExtra);
            $sSolar = $aExtra[0];
            #$sBatt = $aExtra[1] . "0";
	}

	$aMessage = json_decode($jsMessage, true);
	#print_r ($aMessage);
	#printf("\n");
        if (! array_key_exists('f_cnt', $aMessage['uplink_message'])) {
            #printf("$iRow: no f_cnt\n");
            $iF_cnt = 0;   # f_cnt is not included when it is 0
        } else {
            $iF_cnt = $aMessage['uplink_message']['f_cnt'];
        }
        if ($iF_cnt == 0) $iF_cnt_0++;
        #printf("f_cnt=$iF_cnt\n");

        $iSolar = (int) $sSolar;
        $iBatt  = ((int) $sBatt) + rand(-3, 3);   # add 3 mV of noise, so 2 graphs with the same value are a bit more visible
        $iSupp  = ((int) $sSupp) + rand(-3, 3);   # add 3 mV of noise, since gnuplot cannot plot if all values are the same
        if ($iSolar < $iSupp) $sSolar = "?";
        if ($iSolar > 10000)  $sSolar = "?";
        if ($iBatt  < $iSupp) $sBatt  = "?";
        if ($iBatt  > 4500)   $sBatt  = "?";
        if ($sBatt != '?') $iValidBatt++;
        #printf("Solar=$sSolar Batt=$sBatt iSupp=$iSupp\n");

        fprintf($fpCal,  "%s	%s	%s	%s	%d	%d	%d\n", 
        $sLocTimestamp, $sStationId, $sSolar, $sBatt, $iSupp, $iF_cnt, $iF_cnt_0);
    }

    $iRow++;
}


fprintf($fpMet,  "{\"first_time_active\": %d,\n", $iFirstTimeActive);
fprintf($fpMet,  "\"last_time_active\": %d,\n", $iLastTimeActive);
fprintf($fpMet,  "\"first_battery_voltage\": \"%s\",\n", $sFirstBatt);
fprintf($fpMet,  "\"last_battery_voltage\": \"%s\",\n", $sLastBatt);
fprintf($fpMet,  "\"no_valid_battery_voltages\": %d,\n", $iValidBatt);
fprintf($fpMet,  "\"last_f_cnt\": %d,\n", $iF_cnt);
fprintf($fpMet,  "\"no_f_cnt_0\": %d,\n", $iF_cnt_0);
fprintf($fpMet,  "\"last_updated\": %d}\n", $iLastUpdated);


fClose($fpRaw);
fClose($fpMet);
fClose($fpCal);


# ============================================================================================================


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
