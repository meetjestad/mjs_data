<?php

# $Id:$


function  timestamp2unixtime($sTimestamp, $tz) {
     switch ($tz) {
        case "UTC":
            date_default_timezone_set('UTC');
            $unixtime = strtotime($sTimestamp);
            break;
        default:
            date_default_timezone_set('Europe/Amsterdam');
            $unixtime = strtotime($sTimestamp);
            break;
    }

    date_default_timezone_set('Europe/Amsterdam');
    return $unixtime;
};


function  unixtime2timestamp($iUnixtime, $tz) {
    switch ($tz) {
        case "UTC": 
            date_default_timezone_set('UTC');
            $sTimestamp = date("Y-m-d H:i:s", $iUnixtime);
            break;
        default:
            date_default_timezone_set('Europe/Amsterdam');
            $sTimestamp = date("Y-m-d H:i:s", $iUnixtime);
            break;
    }

    date_default_timezone_set('Europe/Amsterdam');
    return $sTimestamp;
};


?>
