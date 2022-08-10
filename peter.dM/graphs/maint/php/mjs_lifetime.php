<?php

# $Id: meetjestad.net/static/graphs/maint/php/mjs_lifetime.php $
# $Author: Peter Demmer for Meetjestad! $
# *** Not used at the moment ***


error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("libmjsdb.php");


$lDeb = 1;

$fpRaw = null;
$fpCal = null;
$fpMet = null;

#$sLastUpdated = date("Y-m-d.H:i:s", time());
$uNow = time();


$aPer = array('01d', '04d', '02w', '02m', '06m', '02y', '06y');
$nD = 86400;
$aDur = array('01d'=>$nD, '04d'=>4*$nD, '02w'=>14*$nD, '02m'=>61*$nD, '06m'=>183*$nD, '02y'=>731*$nD, '06y'=>2192*$nD);
$aPeriod = array('01d'=>'1 day', '04d'=>'4 days', '02w'=>'2 weeks', '02m'=>'2 months', '06m'=>'6 months', '02y'=>'2 years', '06y'=>'6 years');
$aThen = array();
$aCat = array();
foreach ($aPer as $sPer) $aThen[$sPer] = $uNow-$aDur[$sPer];
if ($lDeb > 1) {
    printf("Per:\n");
    print_r($aPer); printf("\n\n");
    printf("Dur:\n");
    print_r($aDur); printf("\n\n");
    printf("Period:\n");
    print_r($aPeriod); printf("\n\n");
    printf("Then:\n");
    print_r($aThen); printf("\n\n");
}


$sWhere = "WHERE timestamp > '2016-06-11 11:35:00'";
$sWhere = "";
$sQuery1 = "SELECT MAX(timestamp), station_id FROM sensors_measurement $sWhere GROUP BY station_id ORDER BY timestamp DESC";

if ($lDeb > 0) printf("sQuery1='$sQuery1'\n");

$aaResult1 = queryr($sQuery1);

$sRawFile = sprintf("../lst/mjs_lifetime_raw.lst");
$fpRaw = fopen($sRawFile, "w");
if ($fpRaw == null) {
    exit("cannot write $sRawFile, abort\n");
}
#fprintf($fpRaw, "-- %s\n", $sQuery1);

$sCalFile = sprintf("../lst/mjs_lifetime_cal.lst");
$fpCal = fopen($sCalFile, "w");
if ($fpCal == null) {
    exit("cannot write $sCalFile, abort\n");
}

$sMetFile = sprintf("../lst/mjs_lifetime_met.lst");
$fpMet = fopen($sMetFile, "w");
if ($fpMet == null) {
    exit("cannot write $sMetFile, abort\n");
}


$iRow=0;
foreach ($aaResult1 as $aRow) { 
    $nCols = sizeof($aRow);
    if ($nCols < 2) {
        printf("Error: row=$iRow cols=$nCols\n");
    } else {
        $sUtcTimestamp = $aRow[0];
        $sStationId = $aRow[1];
        fprintf($fpRaw, "%s	%s\n", $sUtcTimestamp, $sStationId);

        date_default_timezone_set('UTC');
        $uTime = strtotime($sUtcTimestamp);
        date_default_timezone_set('Europe/Amsterdam');
        $sLocTimestamp = date("Y-m-d.H:i:s", $uTime);
        if ($lDeb > 1) printf("UtcTimestamp=$sUtcTimestamp Unixtime=$uTime LocTimestamp=$sLocTimestamp\n");

        if ($uTime <= $aThen['02y'] and $uTime > $aThen['06y']) {
            $eCategory = 'stopped 6-2 years ago';
            $aCat['6y2y'][] = array('station'=>$sStationId, 'timestamp'=>$sUtcTimestamp);
        } else if ($uTime <= $aThen['06m'] and $uTime > $aThen['02y']) {
            $eCategory = 'stopped 24-6 months ago';
            $aCat['2y6m'][] = array('station'=>$sStationId, 'timestamp'=>$sUtcTimestamp);
        } else if ($uTime <= $aThen['02m'] and $uTime > $aThen['06m']) {
            $eCategory = 'stopped 6-2 months ago';
            $aCat['6m2m'][] = array('station'=>$sStationId, 'timestamp'=>$sUtcTimestamp);
        } else if ($uTime <= $aThen['02w'] and $uTime > $aThen['02m']) {
            $eCategory = 'stopped 9-2 weeks ago';
            $aCat['2m2w'][] = array('station'=>$sStationId, 'timestamp'=>$sUtcTimestamp);
        } else if ($uTime <= $aThen['04d'] and $uTime > $aThen['02w']) {
            $eCategory = 'stopped 14-4 days ago';
            $aCat['2w4d'][] = array('station'=>$sStationId, 'timestamp'=>$sUtcTimestamp);
        } else if ($uTime <= $aThen['01d'] and $uTime > $aThen['04d']) {
            $eCategory = 'stopped 4-1 days ago';
            $aCat['4d1d'][] = array('station'=>$sStationId, 'timestamp'=>$sUtcTimestamp);
        } else if ($uTime <= $uNow - 3600  and $uTime > $aThen['01d']) {
            $eCategory = 'stopped 24-1 hours ago';
            $aCat['1d1h'][] = array('station'=>$sStationId, 'timestamp'=>$sUtcTimestamp);
        } else {
            $eCategory = 'active last hour';
            $aCat['1h0h'][] = array('station'=>$sStationId, 'timestamp'=>$sUtcTimestamp);
        }

        if ($lDeb > 1) printf("%s	%s	%s\n", $sStationId, $sLocTimestamp, $eCategory);
        fprintf($fpCal,  "%s	%s	%s\n", $sStationId, $sLocTimestamp, $eCategory);
    }

    $iRow++;
}


foreach ($aCat as $key => $value) {
    if ($lDeb > 1) {
        printf("$key unsorted:\n");
        print_r($aCat[$key]);
    }
    sort($aCat[$key]);   # sorts on 1st element of $value=array, interpreted as integer
    if ($lDeb > 1) {
        printf("$key sorted:\n");
        print_r($aCat[$key]);
        printf("\n");
    }
}

foreach ($aCat as $key => $value) {
    foreach ($value as $val) {
        if ($lDeb > 1) printf("%s	%s	%s\n", $key, $val['station'], $val['timestamp']);
        fprintf($fpMet,  "%s	%s	%s\n", $key, $val['station'], $val['timestamp']);
    }
}

fClose($fpRaw);
fClose($fpCal);
fClose($fpMet);

?>
