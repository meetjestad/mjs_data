<?php

# $Id: meetjestad.net/static/graphs/maint/libmaint.php $
# $Author: Peter Demmer for Meetjestad! $

error_reporting(E_ALL); 
date_default_timezone_set('Europe/Amsterdam');

require_once ("libmjsdb.php");

$bDeb = false;


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


function getmaintdata($iStation_id, $sPer) {
    global $bDeb;

    $iLastUpdated = time();
    
    #$sStation_id = sprintf("%04d", $iStation_id);
    
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
    
    $sQuery1 = "SELECT timestamp, station_id, battery, supply, extra  FROM sensors_measurement  WHERE station_id = $iStation_id  AND timestamp > '$dtStart'  ORDER BY timestamp DESC  LIMIT $nSamples";
    $sQuery1 = "SELECT meas.timestamp, station_id, battery, supply, extra, message FROM sensors_measurement meas, sensors_message msg  WHERE meas.message_id = msg.id  AND station_id = $iStation_id  AND meas.timestamp > '$dtStart'  ORDER BY timestamp DESC  LIMIT $nSamples";
    if ($bDeb) printf("%d   sQuery1='$sQuery1'<br>\n", __LINE__);
    
    $aaResult1 = queryr($sQuery1);
    if ($bDeb) printf("%d   %d rows returned<br>\n", __LINE__, count($aaResult1));
    
    
    $iRow=0;
    $iValidBatt = 0;
    $iFirstBatt = 0;
    $iLastBatt = 0;
    $iFirstTimeActive = -1;
    $iLastTimeActive = -1;
    $iLastBoot = -1;
    $iFCnt = -1;
    $iFCnt_0 = 0;
    $iLastFCnt = -1;
    $aaReturn = [];
    foreach ($aaResult1 as $aRow) {
        $nCols = sizeof($aRow);
        if ($nCols < 3) {
            printf("Error: row=$iRow cols=$nCols\n");
        } else {
            $sUtcTimestamp = $aRow[0];
            $sStationId = $aRow[1];
            $sBatt = $aRow[2];   # 4.32
            $sSupp = $aRow[3];   # 3.29
            $sExtra = $aRow[4];
            $jsMessage = $aRow[5];
    
            date_default_timezone_set('UTC');
            $iUnixtime = strtotime($sUtcTimestamp);
            $iFirstTimeActive = $iUnixtime;
            date_default_timezone_set('Europe/Amsterdam');
            $sLocTimestamp = date("Y-m-d.H:i:s", $iUnixtime);
            if ($iRow == 0) {
                $iLastTimeActive = $iUnixtime;
                $iLastBatt = (int) ($sBatt * 1000);
            }
            #printf("UtcTimestamp=$sUtcTimestamp Unixtime=$iUnixtime LocTimestamp=$sLocTimestamp\n");
    
            $sSolar = "?";
            $sBatt = fmt($sBatt*1000, 0);
            $sSupp = fmt($sSupp*1000, 0);
    
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
            #if ($iStation_id == 754 ) $bDeb = true;
            if (array_key_exists('uplink_message', $aMessage)) {   # old messages may not be available anymore
                if ($bDeb) {
                    print_r ($aMessage['uplink_message']);
                    printf("<br><br>\n");
                }
                if (! array_key_exists('f_cnt', $aMessage['uplink_message'])) {
                    #printf("$iRow: no f_cnt\n");
                    $iFCnt = 0;   # f_cnt not included when it is 0
                } else {
                    $iFCnt = (int) $aMessage['uplink_message']['f_cnt'];
                }
                if ($iFCnt == 0) $iFCnt_0++;
                if ($iLastBoot == -1 and $iFCnt == 0) $iLastBoot = $iUnixtime;
                if ($iRow == 0) $iLastFCnt = $iFCnt;
                if ($bDeb) printf("last_f_cnt=$iLastFCnt f_cnt=$iFCnt\n");
            }
            $bDeb = false;

            $iSolar = (int) $sSolar;
            $iSupp  = ((int) $sSupp) + rand(-3, 3);   # add 3 mV of noise, since gnuplot cannot plot if all values are the same
            if ($iSolar < $iSupp) $sSolar = "?";
            if ($iSolar > 10000)  $sSolar = "?";
            $iBatt = (int) $sBatt;
            if ($iBatt  < $iSupp) $sBatt  = "?";
            if ($iBatt  > 4500)   $sBatt  = "?";
            if ($sBatt != '?') {
                #$iBatt  = ((int) $sBatt) + rand(-3, 3);   # add 3 mV of noise, so 2 graphs with the same value are a bit more visible
                $iFirstBatt = $iBatt;
                $iValidBatt++;
            }
    
            $aReturn = array($sLocTimestamp, $sStationId, $sSolar, $sBatt, $iSupp);
            $aaReturn[] = $aReturn;
        }
    
        $iRow++;
    }

    if ($iLastBoot == -1) {   # no reboots in this period, extrapolate
        if ($iRow > 1) {
            $fPeriod = ($iLastTimeActive - $iFirstTimeActive) / $iRow;   # typically a bit more then 900"
            $iLastBoot = (int) ($iLastTimeActive - $fPeriod * $iLastFCnt);
            #$bDeb = true;
            if ($bDeb) printf("LastTimeActive=$iLastTimeActive FirstTimeActive=$iFirstTimeActive Rows=$iRow Period=%.0f LastBoot=$iLastBoot<br\n", $fPeriod);
            $bDeb = false;
        }
    }

#if ($iStation_id == 754) $bDeb = true;
    if ($bDeb) {
        printf("first_time_active=$iFirstTimeActive<br>\n");
        printf("last_time_active=$iLastTimeActive<br>\n");
        printf("first_battery_voltage=$iFirstBatt<br>\n");
        printf("last_battery_voltage=$iLastBatt<br>\n");
        printf("no_valid_battery_voltages=$iValidBatt<br>\n");
        printf("no_measurements=$iRow<br>\n");
        printf("last_f_cnt=%d,<br>\n", $iLastFCnt);
        printf("no_f_cnt_0=%d,<br>\n", $iFCnt_0);
        printf("last_boot=%d,<br>\n", $iLastBoot);
        printf("last_updated=$iLastUpdated<br>\n");
    }
$bDeb = false;

    $sReturn_json =  sprintf("{ \"first_time_active\": %d,\n", $iFirstTimeActive);
    $sReturn_json .= sprintf("\"last_time_active\": %d,\n", $iLastTimeActive);
    $sReturn_json .= sprintf("\"first_battery_voltage_mV\": %d,\n", $iFirstBatt);
    $sReturn_json .= sprintf("\"last_battery_voltage_mV\": %d,\n", $iLastBatt);
    $sReturn_json .= sprintf("\"no_valid_battery_voltages\": %d,\n", $iValidBatt);
    $sReturn_json .= sprintf("\"no_measurements\": %d,\n", $iRow);
    $sReturn_json .= sprintf("\"last_f_cnt\": %d,\n", $iLastFCnt);
    $sReturn_json .= sprintf("\"no_f_cnt_0\": %d,\n", $iFCnt_0);
    $sReturn_json .= sprintf("\"last_boot\": %d,\n", $iLastBoot);
    $sReturn_json .= sprintf("\"last_updated\": %d }\n", $iLastUpdated);
    
    return(array($sReturn_json, $aaReturn));
}


?>
