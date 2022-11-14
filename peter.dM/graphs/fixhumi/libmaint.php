<?php

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
    if ($bDeb) printf("%d   sQuery1='$sQuery1'<br>\n", __LINE__);
    
    $aaResult1 = queryr($sQuery1);
    if ($bDeb) printf("%d   %d rows returned<br>\n", __LINE__, count($aaResult1));
    
    
    $iRow=0;
    $iValidBatt = 0;
    $iFirstBatt = 0;
    $aaReturn = [];
    foreach ($aaResult1 as $aRow) {
        $nCols = sizeof($aRow);
        if ($nCols < 3) {
            printf("Error: row=$iRow cols=$nCols\n");
        } else {
            $sUtcTimestamp = $aRow[0];
            $sStationId = $aRow[1];
            $sBatt = $aRow[2];
            $sSupp = $aRow[3];
            $sExtra = $aRow[4];
    
            date_default_timezone_set('UTC');
            $iUnixtime = strtotime($sUtcTimestamp);
            $iFirstTimeActive = $iUnixtime;
            date_default_timezone_set('Europe/Amsterdam');
            $sLocTimestamp = date("Y-m-d H:i:s", $iUnixtime);
            $sLocTimestamp = str_replace(" ", ".", $sLocTimestamp);
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

    if ($bDeb) {
        printf("first_time_active=$iFirstTimeActive<br>\n");
        printf("last_time_active=$iLastTimeActive<br>\n");
        printf("first_battery_voltage=$iFirstBatt<br>\n");
        printf("last_battery_voltage=$iLastBatt<br>\n");
        printf("no_valid_battery_voltages=$iValidBatt<br>\n");
        printf("no_measurements=$iRow<br>\n");
        printf("last_updated=$iLastUpdated<br>\n");
    }

    $sReturn_json =  sprintf("{\"first_time_active\": %d,\n", $iFirstTimeActive);
    $sReturn_json .= sprintf("\"last_time_active\": %d,\n", $iLastTimeActive);
    $sReturn_json .= sprintf("\"first_battery_voltage_mV\": %d,\n", $iFirstBatt);
    $sReturn_json .= sprintf("\"last_battery_voltage_mV\": %d,\n", $iLastBatt);
    $sReturn_json .= sprintf("\"no_valid_battery_voltages\": %d,\n", $iValidBatt);
    $sReturn_json .= sprintf("\"no_measurements\": %d,\n", $iRow);
    $sReturn_json .= sprintf("\"last_updated\": %d}\n", $iLastUpdated);
    
    return(array($sReturn_json, $aaReturn));
}


?>
