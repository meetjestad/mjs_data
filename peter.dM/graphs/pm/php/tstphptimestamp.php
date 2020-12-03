<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

$sHome = '/home/mjs_data';
require_once ("$sHome/php/libtimestamp.php");

# 2019-06-07 21:08:32

$sTimestampU = array('2019-03-31 00:00:00', '2019-03-31 01:00:00', '2019-03-31 02:00:00', '2019-03-31 03:00:00');

foreach($sTimestampU as $sTimestamp) {
    $iUnixtime = timestamp2unixtime($sTimestamp, 'UTC');
    $sTimestampL = unixtime2timestamp($iUnixtime, 'local');
    printf("UTC='%s'	unixtime=%u	local='%s'\n", $sTimestamp, $iUnixtime,  $sTimestampL);
}

printf("\n");

foreach($sTimestampU as $sTimestamp) {
    $iUnixtime = timestamp2unixtime($sTimestamp, 'local');
    $sTimestampL = unixtime2timestamp($iUnixtime, 'UTC');
    printf("local='%s'	unixtime=%u	UTC='%s'\n", $sTimestamp, $iUnixtime,  $sTimestampL);
}

?>
