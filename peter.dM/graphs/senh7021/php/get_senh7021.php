<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');
#date_default_timezone_set('UTC');

require_once ("mjstest_env.php");

$fpRaw = null;
$fpPhys = null;


if ($argc < 3) {
    printf("usage: $argv[0] temp|humi|dewp period\n");
    exit(1);
} 
$sPhys = $argv[1];
if ($sPhys != "temp" && $sPhys != "humi" && $sPhys != "dewp") {
    printf("usage: $sPhys not in ('temp','humi','dewp'); abort\n");
    exit (1);
}
$sPer = $argv[2];


$sRawFile = sprintf("../lst/balc_7021n_%s_%s.lst", $sPhys, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
#fprintf($fpRaw, "-- %s\n", $sQueryV);
$sPhysFile = sprintf("../lst/balc_7021n_%s_sb_%s.lst", $sPhys, $sPer);
$fpPhys = fopen($sPhysFile, "w");
if ($fpPhys == null) {
    exit("cannot write $sPhysFile, abort\n");
}


$sQueryT = "SELECT max(unixtime) + 1 FROM knmi_th";
$aaResultT = queryr($sQueryT);
foreach ($aaResultT as $aRowT) {
    $uEndTime = $aRowT[0];
}

if ($sPer == '04d') {
    $uStartTime = $uEndTime - 4 * 86400;
} else if ($sPer == '02w') {
    $uStartTime = $uEndTime - 14 * 86400;
} else if ($sPer == '02m') {
    $uStartTime = $uEndTime - 60 * 86400;
} else if ($sPer == '06m') {
    $uStartTime = $uEndTime - 182 * 86400;
} else {
    $uStartTime = $uEndTime - 1 * 86400;
}
$dtStart = date("Y-m-d H:i:s", $uStartTime);
$dtEnd   = date("Y-m-d H:i:s", $uEndTime);
#printf("dtStart='$dtStart' ($uStartTime') dtEnd='$dtEnd' ($uEndTime)\n");


$sQueryV = "SELECT DISTINCT FROM_UNIXTIME(s.unixtime), 
    s1.$sPhys as v1, s2.$sPhys as v2, s3.$sPhys as v3, s4.$sPhys as v4, s5.$sPhys as v5, s6.$sPhys as v6,
    s1.heat as h1, s2.heat as h2, s3.heat as h3, s4.heat as h4, s5.heat as h5, s6.heat as h6
FROM sens7021 AS s 
    LEFT JOIN sens7021 AS s1 ON (s.gmtijd = s1.gmtijd AND s1.port = 1) 
    LEFT JOIN sens7021 AS s2 ON (s.gmtijd = s2.gmtijd AND s2.port = 2) 
    LEFT JOIN sens7021 AS s3 ON (s.gmtijd = s3.gmtijd AND s3.port = 3) 
    LEFT JOIN sens7021 AS s4 ON (s.gmtijd = s4.gmtijd AND s4.port = 4) 
    LEFT JOIN sens7021 AS s5 ON (s.gmtijd = s5.gmtijd AND s5.port = 5) 
    LEFT JOIN sens7021 AS s6 ON (s.gmtijd = s6.gmtijd AND s6.port = 6) 
WHERE s.source = 'meet6' 
    AND FROM_UNIXTIME(s.unixtime) > '$dtStart' 
    AND FROM_UNIXTIME(s.unixtime) <= '$dtEnd' 
ORDER BY s.unixtime ASC";
#printf("QueryV='$sQueryV'\n");

$aaResultV = queryr($sQueryV);

$iHeat1 = 0;
$iHeat2 = 0;
$iHeat3 = 0;
$iHeat4 = 0;
$iHeat5 = 0;
$iHeat6 = 0;
$iRow=0;
foreach ($aaResultV as $aRowV) {
    $nCols = sizeof($aRowV);
    if ($nCols < 3) {
        printf("Error: row=$iRow cols=$nCols\n");
    } else {
        $sUtcTimestamp = $aRowV[0];
        $sPhys1 = $aRowV[1]; if ($sPhys1 == "" || $iHeat1 > 0) { $sPhys1 = "?"; }
        $sPhys2 = $aRowV[2]; if ($sPhys2 == "" || $iHeat2 > 0) { $sPhys2 = "?"; }
        $sPhys3 = $aRowV[3]; if ($sPhys3 == "" || $iHeat3 > 0) { $sPhys3 = "?"; }
        $sPhys4 = $aRowV[4]; if ($sPhys4 == "" || $iHeat4 > 0) { $sPhys4 = "?"; }
        $sPhys5 = $aRowV[5]; if ($sPhys5 == "" || $iHeat5 > 0) { $sPhys5 = "?"; }
        $sPhys6 = $aRowV[6]; if ($sPhys6 == "" || $iHeat6 > 0) { $sPhys6 = "?"; }
        $iHeat1 = (int) $aRowV[7];
        $iHeat2 = (int) $aRowV[8];
        $iHeat3 = (int) $aRowV[9];
        $iHeat4 = (int) $aRowV[10];
        $iHeat5 = (int) $aRowV[11];
        $iHeat6 = (int) $aRowV[12];
        fprintf($fpRaw, "%s	%s	%s	%s	%s	%s	%s	%d %d %d %d %d %d\n", 
	    $sUtcTimestamp, $sPhys1, $sPhys2, $sPhys3, $sPhys4, $sPhys5, $sPhys6, $iHeat1, $iHeat2, $iHeat3, $iHeat4, $iHeat5, $iHeat6);

        #date_default_timezone_set('UTC');
        #$iUnixtime = strtotime($sUtcTimestamp);
        #date_default_timezone_set('Europe/Amsterdam');
        #$sLocTimestamp = date("Y-m-d H:i:s", $iUnixtime);
	#$sLocTimestamp = str_replace(" ", ".", $sLocTimestamp);
	$sLocTimestamp = str_replace(" ", ".", $sUtcTimestamp);
	#printf("UtcTimestamp=$sUtcTimestamp Unixtime=$iUnixtime LocTimestamp=$sLocTimestamp\n");
	
	if ($iHeat1 > 0) { $sPhys1 = "?"; }
	if ($iHeat2 > 0) { $sPhys2 = "?"; }
	if ($iHeat3 > 0) { $sPhys3 = "?"; }
	if ($iHeat4 > 0) { $sPhys4 = "?"; }
	if ($iHeat5 > 0) { $sPhys5 = "?"; }
	if ($iHeat6 > 0) { $sPhys6 = "?"; }
        fprintf($fpPhys, "%s	%s	%s	%s	%s	%s	%s	%d %d %d %d %d %d\n", 
	    $sLocTimestamp, $sPhys1, $sPhys2, $sPhys3, $sPhys4, $sPhys5, $sPhys6, $iHeat1, $iHeat2, $iHeat3, $iHeat4, $iHeat5, $iHeat6);
    }

    $iRow++;
}

fClose($fpRaw);
fClose($fpPhys);


?>
