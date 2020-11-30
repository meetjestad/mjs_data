<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("libtestdb.php");

$fFactor = exp(-1./7./24.);   # exp( - tijd / 1 week )
printf("-- factor=$fFactor\n");
$fRegen7dNieuw = null;
$sQuery1 = "SELECT t1.localtijd, t1.unixtime, t1.regen, t1.regen7d, t2.localtijd, t2.unixtime, t2.regen, t2.regen7d FROM knmi_th t1, knmi_th t2 WHERE t2.unixtime = t1.unixtime + 3600 AND t1.regen IS NOT NULL AND t2.regen7d IS NULL";
$aaResult1 = queryr($sQuery1);
foreach ($aaResult1 as $aRow) {
        $sLocaltijd1 = $aRow[0];
        $iUnixtime1 = $aRow[1];
        $fRegen1 = $aRow[2];
	$fRegen7d1 = $aRow[3];
	if ($fRegen7d1 == 'NULL') { $fRegen7d1 = null; }   # last Sunday in October 02:59:59
        $sLocaltijd2 = $aRow[4];
        $iUnixtime2 = $aRow[5];
        $fRegen2 = $aRow[6];
        $fRegen7d2 = $aRow[7];
	printf("'$sLocaltijd1', $iUnixtime1, $fRegen1, $fRegen7d1,   '$sLocaltijd2', $iUnixtime2, $fRegen2, $fRegen7d2.\n");
	if ($fRegen2 < 0.) { $fRegen2 = 0.; } 
	# user the one occurrence in the first line:
	if ($fRegen7d1 != null) { $fRegen7dNieuw = $fRegen7d1; }
        $fRegen7dNieuw = $fRegen7dNieuw * $fFactor + $fRegen2;
	$sQuery3 = "UPDATE knmi_th SET regen7d = $fRegen7dNieuw WHERE unixtime = $iUnixtime2;";
	# printf("$sLocaltijd2   $sQuery3\n");
	printf("$sQuery3\n");
	queryw($sQuery3);
}

?>
