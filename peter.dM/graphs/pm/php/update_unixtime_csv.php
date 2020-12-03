<?php

error_reporting(E_ALL);   // PHP
$tBegin = time();
date_default_timezone_set('Europe/Amsterdam');

$sHome = '/home/mjs_data';
require_once ("$sHome/php/libmjsdb.php");

$nAantal = 1000;
if ($argc > 1) {
    if (is_numeric($argv[1])) $nAantal = (int) $argv[1];
}
if ($nAantal > 250000) {
    $nAantal = 250000;
    printf("aantal beperkt tot %d\n", $nAantal);
}

$sQuery = "SELECT timestamp, stationid, source FROM measurements WHERE source = 'csv' AND unixtime IS NULL LIMIT $nAantal";

$aaResult = libqueryr($sQuery);
$tEinde = time();
printf("gevonden %d rijen na %dm%02ds\n", sizeof($aaResult), ($tEinde - $tBegin) / 60, ($tEinde - $tBegin) % 60);

$fUit = fopen("$sHome/php/update_unixtime_csv.uit", 'w');
foreach ($aaResult as $aRow) {
    $sQuery = sprintf("UPDATE measurements SET unixtime = UNIX_TIMESTAMP(CONVERT_TZ(timestamp, '+00:00', @@global.time_zone)) WHERE timestamp = '%s' AND unixtime IS NULL AND stationid = %s AND source = '%s';\n", 
       $aRow[0], $aRow[1], $aRow[2]);
   # printf($sQuery);
   fputs($fUit, $sQuery);
}
fclose($fUit);

$tEinde = time();
printf("geschreven %d rijen na %dm%02ds\n", sizeof($aaResult), ($tEinde - $tBegin) / 60, ($tEinde - $tBegin) % 60);

?>
