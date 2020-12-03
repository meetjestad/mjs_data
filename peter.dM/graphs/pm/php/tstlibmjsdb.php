<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

$sHome = '/home/mjs_data';
require_once ("$sHome/php/libmjsdb.php");

$sQuery = "SELECT timestamp, stationid, source FROM measurements WHERE source = 'csv' AND unixtime IS NULL LIMIT 10";

$aaResult = libqueryr($sQuery);

foreach ($aaResult as $aRow) {
   $nCols = sizeof($aRow);
   for ($iCol = 0; $iCol < $nCols; $iCol++) {
       printf("%s	", $aRow[$iCol]);
   }
   printf("\n");
}

?>
