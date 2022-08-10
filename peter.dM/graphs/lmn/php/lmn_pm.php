<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("libtestdb.php");


$iDeb = 0;

$fpRaw = null;
$fpCal = null;
$fpInt = null;


if ($argc < 3) {
    printf("usage: $argv[0] lmn_station period\n");
    exit(1);
} 

$sLmnStation = $argv[1];

$sPer = $argv[2];
if ($sPer == '01d') {
    $nSamples = 1 * 24;
} else if ($sPer == '04d') {
    $nSamples = 4 * 24;
} else if ($sPer == '02w') {
    $nSamples = 14 * 24;
} else if ($sPer == '02m') {
    $nSamples = 61 * 24;
} else if ($sPer == '06m') {
    $nSamples = 183 * 24;
} else if ($sPer == '02y') {
    $nSamples = 731 * 24;
} else {
    $nSamples = 1 * 24;
}
#printf("nSamples=$nSamples\n");

$sQuery1 = "SELECT timestamp, unixtime, lmn_station, pm25  FROM  lmn_pm  WHERE  lmn_station = '$sLmnStation'  ORDER BY unixtime DESC  LIMIT $nSamples";
#printf("sQuery1='$sQuery1'\n");

$aaResult1 = queryr($sQuery1);

$sRawFile = sprintf("../lst/lmn_pm_%s_raw_%s.lst", $sLmnStation, $sPer);
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
#fprintf($fpRaw, "-- %s\n", $sQuery1);

$sCalFile = sprintf("../lst/lmn_pm_%s_cal_%s.lst", $sLmnStation, $sPer);
$fpCal = fopen($sCalFile, "w");
if ($fpCal == null) {
    exit("cannot write $sCalFile, abort\n");
}

$sIntFile = sprintf("../lst/lmn_pm_%s_int_%s.lst", $sLmnStation, $sPer);
$fpInt = fopen($sIntFile, "w");
if ($fpInt == null) {
    exit("cannot write $sIntFile, abort\n");
}


$iRow=0;
foreach ($aaResult1 as $aRow) {
    $nCols = sizeof($aRow);
    if ($nCols < 3) {
        printf("Error: row=$iRow cols=$nCols\n");
    } else {
        $sUtcTimestamp = $aRow[0];
        $uEpoch = $aRow[1];
        $sLmnStation = $aRow[2];
        $sPM25 = $aRow[3];
        $fPM25 = (float) $sPM25;
        fprintf($fpRaw, "%s	%s	%s	%6s\n", 
            $sUtcTimestamp, $uEpoch, $sLmnStation, $sPM25);

        #date_default_timezone_set('UTC');
        #$uEpoch = strtotime($sUtcTimestamp);
        date_default_timezone_set('Europe/Amsterdam');
        # Measurement time = e.g. 13:00 UTC, translates to 14:00 MET (15:00 MEST), is an average for the last hour => sample time 13:30 MET
        $uTimeshift = -1800;
        $sLocTimestamp = date("Y-m-d.H:i:s", $uEpoch + $uTimeshift);
        #$sLocTimestamp = str_replace(" ", ".", $sLocTimestamp);
        #printf("UtcTimestamp=$sUtcTimestamp Unixtime=$uEpoch LocTimestamp=$sLocTimestamp\n");

        fprintf($fpCal,  "%s	%s	%6s\n", 
                $sLocTimestamp, $sLmnStation, $sPM25);

        # Note: this runs back in time: UnixtimeOld > Unixtime !
        if ($iRow == 0) {
            fprintf($fpInt,  "%s	%s	%s	%6.2f	0\n", $sLocTimestamp, $uEpoch + $uTimeshift, $sLmnStation, $fPM25);
	} else {
            if ($iDeb > 0) printf("Row=$iRow LocTimestamp=$sLocTimestamp UnixtimeOld=$uEpochOld Unixtime=$uEpoch sPM25=$sPM25 fPM25=$fPM25\n");

	    # 45 minutes later:
            $uEpoch3 = 0.75 * $uEpochOld + 0.25 * $uEpoch + $uTimeshift;
            $sLocTimestamp3 = date("Y-m-d.H:i:s", $uEpoch3);
            $fPM25c = 0.75 * $fPM25old + 0.25 * $fPM25;
            fprintf($fpInt,  "%s	%s	%s	%6.2f	3\n", $sLocTimestamp3, $uEpoch3, $sLmnStation, $fPM25c);

	    # 30 minutes later:
            $uEpoch2 = 0.5 * $uEpochOld + 0.5 * $uEpoch + $uTimeshift;
            $sLocTimestamp2 = date("Y-m-d.H:i:s", $uEpoch2);
            $fPM25b = 0.5 * $fPM25old + 0.5 * $fPM25;
            fprintf($fpInt,  "%s	%s	%s	%6.2f	2\n", $sLocTimestamp2, $uEpoch2, $sLmnStation, $fPM25b);

	    # 15 minutes later:
            $uEpoch1 = 0.25 * $uEpochOld + 0.75 * $uEpoch + $uTimeshift;
            $sLocTimestamp1 = date("Y-m-d.H:i:s", $uEpoch1);
            $fPM25a = 0.25 * $fPM25old + 0.75 * $fPM25;
            fprintf($fpInt,  "%s	%s	%s	%6.2f	1\n", $sLocTimestamp1, $uEpoch1, $sLmnStation, $fPM25a);

	    # Now:
            fprintf($fpInt,  "%s	%s	%s	%6.2f	0\n", $sLocTimestamp, $uEpoch + $uTimeshift, $sLmnStation, $fPM25);
	}

        #$sLocTimestampOld = $sLocTimestamp;
        $uEpochOld = $uEpoch;
        #$sPM25old = $sPM25;
        $fPM25old = $fPM25;
    }

    $iRow++;
}

fClose($fpRaw);
fClose($fpCal);
fClose($fpInt);


?>
