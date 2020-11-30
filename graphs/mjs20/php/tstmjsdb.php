<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

#$sHome = '/home/mjs_data';
#require_once ("$sHome/php/libmjsdb.php");
require_once ("libmjsdb.php");

$sQuery = "SELECT timestamp, station_id, temperature, humidity, extra FROM sensors_measurement WHERE station_id = 2002 ORDER BY timestamp DESC LIMIT 10";

$aaResult = queryr($sQuery);

foreach ($aaResult as $aRow) {
    $nCols = sizeof($aRow);
    $sResult = "";
    for ($iCol = 0; $iCol < $nCols; $iCol++) {
        $sResult = $sResult . sprintf("%s,", $aRow[$iCol]);
    }
    #printf("nCols=$nCols sResult=$sResult\n");
    $sResult = $sResult . "\n";
    $sResult = str_replace(' ', '.', $sResult);
    $sResult = str_replace(',', ' ', $sResult);
    printf($sResult);
}

?>
