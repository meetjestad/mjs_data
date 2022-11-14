<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("libmjsdb.php");
require_once ("libdewp.php");
require_once ("libmath.php");

$iDeb = 0;

if ($argc < 3) {
    printf("usage: $argv[0] temperature dewpoint\n");
    exit(1);
} 

$sTemp = $argv[1];
$fTemp = (float) $sTemp;
$sDewp = $argv[2];
$fDewp = (float) $sDewp;

$fHumi = TempDewp2relHumi($fTemp, $fDewp);

if ($iDeb > 0) {
    printf("Temp=%.2f Dewp=%.2f Humi=%.2f\n", $fTemp, $fDewp, $fHumi);
} else {
    printf("%.2f\n", $fHumi);
}

?>
