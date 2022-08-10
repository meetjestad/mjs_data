<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!-- $Id: meetjestad.net/static/graphs/maint/maint_lifetime.php $ -->
<!-- $Author: Peter Demmer for Meetjestad! $ -->

<HTML>
    <HEAD>
        <TITLE>maint/lifetime</title>
        <LINK HREF="../../style/meetjestad.css" REL="stylesheet" TYPE="text/css" MEDIA="all" />
        <LINK HREF="maint_lifetime.css" REL="stylesheet" TYPE="text/css" MEDIA="all" />
    </head>
    <BODY>
        <A HREF=../../..>Meet je Stad!</a><P>
        <A HREF=..>Meet je Stad! graphs</a><P>
        <A HREF=.>MeetjeStad! maintenance</a><P>
        <A NAME=top></a>
        <H2>Meetjestad! stations that have stopped</h2>
    <H3><A HREF=#bottom>Bottom</a>: list of stations per region</h3>
        <br>


<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

require_once ("php/libmjsdb.php");
#require_once ("php/libmjsgeo.php");
require_once ("/home/meetjestad/web/meetjestad.net/public_html/static/graphs/maint/php/libmjsgeo.php");


# Ref: https://stackoverflow.com/questions/10053358/measuring-the-distance-between-two-coordinates-in-php
function circle_distance1($lat1, $lon1, $lat2, $lon2) {
      $rad = M_PI / 180;
        return acos(sin($lat2*$rad) * sin($lat1*$rad) + cos($lat2*$rad) * cos($lat1*$rad) * cos($lon2*$rad - $lon1*$rad)) * 6371;   // Kilometers
}


if (!function_exists('array_first_key')) {
    function array_first_key(array $arr) {
        foreach($arr as $key => $unused) {
            return $key;
        }
        return NULL;
    }
}


# --- main() ---------------------------------------------------------------------

$uBegin = time();
$uNow = time();
$lDeb = 0;

$aPer = array('01d', '04d', '02w', '02m', '06m', '02y', '06y');
$nD = 86400;
$aDur = array('01d'=>$nD, '04d'=>4*$nD, '02w'=>14*$nD, '02m'=>61*$nD, '06m'=>183*$nD, '02y'=>731*$nD, '06y'=>2192*$nD);
$aPeriod= array('1d6h'=>'24 and 6 hours', '4d1d'=>'4 and 1 days', '2w4d'=>'14 and 4 days', '2m2w'=>'8 and 2 weeks', '6m2m'=>'6 and 2 months', '2y6m'=>'24 and 6 months', '6y2y'=>'6 and 2 years');
$aThen = array();
$aCat = array();
foreach ($aPer as $sPer) $aThen[$sPer] = $uNow-$aDur[$sPer];

if ($lDeb > 1) {
    printf("Per:\n");
    print_r($aPer); printf("\n\n");
    printf("Dur:\n");
    print_r($aDur); printf("\n\n");
    printf("Then:\n");
    print_r($aThen); printf("\n\n");
}


printf("<A HREF=maint_lifetime.php>Refreshed</a> %s<br><br>\n", date("H:i:s"));

foreach($aPeriod as $key => $value) {
    printf("<A HREF=#%s>Stations that have stopped between %s ago</a><br>\n", $key, $value);
}
printf("<br><br>\n");


$sWhere = "WHERE timestamp > '2016-06-11 11:35:00'";
$sWhere = "";
$sQuery1 = "SELECT MAX(timestamp), station_id FROM sensors_measurement $sWhere GROUP BY station_id ORDER BY timestamp DESC";
# TO DO: use sensors_station.last measurement and also obtain latitude and logitude from there.
# If latitude and longitude are 0 or -1 there, use getGeo() to get them from history.
if ($lDeb > 0) printf("sQuery1='$sQuery1'\n");
$aaResult1 = queryr($sQuery1);


$iRow=0;
foreach ($aaResult1 as $aRow) { 
    $nCols = sizeof($aRow);
    if ($nCols < 2) {
        printf("Error: row=$iRow cols=$nCols\n");
    } else {
        $sUtcTimestamp = $aRow[0];
        $sStationId = $aRow[1];

        date_default_timezone_set('UTC');
        $uTime = strtotime($sUtcTimestamp);
        date_default_timezone_set('Europe/Amsterdam');
        $sLocTimestamp = date("Y-m-d.H:i:s", $uTime);
        if ($lDeb > 1) printf("UtcTimestamp=$sUtcTimestamp Unixtime=$uTime LocTimestamp=$sLocTimestamp\n");

        if ($uTime <= $aThen['02y'] and $uTime > $aThen['06y']) {
            $eCategory = 'stopped 6-2 years ago';
            $aCat['6y2y'][] = array('station'=>$sStationId, 'timestamp'=>$sLocTimestamp);
        } else if ($uTime <= $aThen['06m'] and $uTime > $aThen['02y']) {
            $eCategory = 'stopped 24-6 months ago';
            $aCat['2y6m'][] = array('station'=>$sStationId, 'timestamp'=>$sLocTimestamp);
        } else if ($uTime <= $aThen['02m'] and $uTime > $aThen['06m']) {
            $eCategory = 'stopped 6-2 months ago';
            $aCat['6m2m'][] = array('station'=>$sStationId, 'timestamp'=>$sLocTimestamp);
        } else if ($uTime <= $aThen['02w'] and $uTime > $aThen['02m']) {
            $eCategory = 'stopped 9-2 weeks ago';
            $aCat['2m2w'][] = array('station'=>$sStationId, 'timestamp'=>$sLocTimestamp);
        } else if ($uTime <= $aThen['04d'] and $uTime > $aThen['02w']) {
            $eCategory = 'stopped 14-4 days ago';
            $aCat['2w4d'][] = array('station'=>$sStationId, 'timestamp'=>$sLocTimestamp);
        } else if ($uTime <= $aThen['01d'] and $uTime > $aThen['04d']) {
            $eCategory = 'stopped 4-1 days ago';
            $aCat['4d1d'][] = array('station'=>$sStationId, 'timestamp'=>$sLocTimestamp);
        } else if ($uTime <= $uNow - 6 * 3600  and $uTime > $aThen['01d']) {
            $eCategory = 'stopped 24-6 hours ago';
            $aCat['1d6h'][] = array('station'=>$sStationId, 'timestamp'=>$sLocTimestamp);
        } else {
            $eCategory = 'active last hour';
            $aCat['6h0h'][] = array('station'=>$sStationId, 'timestamp'=>$sLocTimestamp);
        }

        if ($lDeb > 1) printf("%s	%s	%s\n", $sStationId, $sLocTimestamp, $eCategory);
    }

    $iRow++;
}


# sort: group by time range, then sort on station:
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


$lZoom = 15;
$aaGeo = array();
$aaList = array();
#$nCount = 0;
foreach ($aCat as $key => $value) {
    $uBegin1 = time();
    $nCount = 0;
    if ($key == '6h0h') {
        printf("<B>%d stations were active in the last 6 hours</b><br>\n", count($value));
        foreach ($value as $val) {
            $aGeo = getGeo($val['station']);
            $aaGeo[] = array($val['station'], $key, $aGeo[0], $aGeo[3], $aGeo[4]);
            if (!key_exists($aGeo[3], $aaList)) {
                $aaList[$aGeo[3]] = $val['station'];
            } else {
                $aaList[$aGeo[3]] .= ',' . $val['station'];
            }
        }
        printf("%d queries took %d seconds<br><br><hr>\n", count($value), time() - $uBegin1);
    } else  {
    #} else  if ($key != '6y2y' and $key != '2y6m' and $key != '6m2m' and $key != '2m2w') {
        printf("<A NAME=%s></a>\n", $key);
        printf("<B>%d stations that have stopped between %s ago:</b><br>\n", count($value), $aPeriod[$key]);
        printf("<TABLE BORDER=1>\n");
        printf("<TR> <TH>station</th> <TH>last seen</th> <TH>#</th> <TH>last geo</th> <TH>region</th> <TH>distance</th> </tr>\n");
        foreach ($value as $val) {
            printf("<TR>\n");
            printf("<TD>%s</td>", $val['station']);
            printf("<TD><A HREF=../../data/sensors_recent.php?sensor=%s&limit=50>%s&nbsp;&nbsp;%s</a></td>\n", 
                $val['station'], substr($val['timestamp'], 0, 10), substr($val['timestamp'], 11, 5));
            $aGeo = getGeo($val['station']);
            $aaGeo[] = array($val['station'], $key, $aGeo[0], $aGeo[3], $aGeo[4]);
            if (!key_exists($aGeo[3], $aaList)) {
                $aaList[$aGeo[3]] = $val['station'];
            } else {
                $aaList[$aGeo[3]] .= ',' . $val['station'];
            }
            if ($aGeo[1].$aGeo[2] == "0.0.") {
            #if ($aGeo[1].$aGeo[2] == "0.0." or $aGeo[1].$aGeo[2] == "-1.-1") {
                $sQuery2 = sprintf("SELECT COUNT(*) FROM sensors_measurement WHERE station_id = %s", $val['station']);
		$aaResult2 = queryr($sQuery2);
		$nAantal = 0;
                foreach ($aaResult2 as $aRow2) { 
                    $nAantal = $aRow2[0];
		}
		$nCount += 1;
                printf("<TD>$nAantal</td>");
                printf("<TD>&nbsp;</td> <TD>&nbsp;</td> <TD>&nbsp;</td>");
            } else {
                $sGeo = sprintf("%s, &nbsp; %s", $aGeo[1], $aGeo[2]);
                # e.g. https://www.openstreetmap.org/?mlat=52.1621&mlon=5.3812#map=12/52.1621/5.3811
                $sUrl = sprintf("https://www.openstreetmap.org/?mlat=%s&mlon=%s#map=%d/%s/%s", 
                    $aGeo[1], $aGeo[2], $lZoom, $aGeo[1], $aGeo[2]);
                printf("<TD>&nbsp;</td>");
                printf("<TD><A HREF=%s>%s</a></td> <TD>%s</td> <TD>%s</td> \n", $sUrl, $sGeo, $aGeo[3], $aGeo[4]);
            }
            printf("</tr>\n");
        }
        printf("</table>\n");
        printf("%d + %d queries took %d seconds<br>\n", count($value), $nCount, time() - $uBegin1);
        printf("<A HREF=#top>top</a><br><br>\n");
        printf("<hr>\n");
    }
}


if ($lDeb > 0) {
    printf("<TABLE BORDER=1>\n");
    foreach ($aaGeo as $aGeo) {                                                    # station   period    lastseen  region    distance
        printf("<TR><TD>%s</td><TD>%s</td><TD>%s</td><TD>%s</td><TD>%s</td></tr>\n", $aGeo[0], $aGeo[1], $aGeo[2], $aGeo[3], $aGeo[4]);
    }
    printf("</table><br>\n");
}


printf("<A NAME=bottom></a>\n");
printf("<B>Stations per region:</b><br>\n");
printf("<TABLE BORDER=1>\n");
ksort($aaList);
$nTotal = 0;
foreach ($aaList as $key => $lValues) {
    if ($key == "&nbsp;") {
        $key1 = "?"; 
    } else {
        $key1=$key;
    }

    $aValues = explode(',', $lValues);
    $nAantal = count($aValues);
    $nTotal += $nAantal;
    asort($aValues, SORT_NUMERIC);
    $sValues = "";
    $oCent = -1;
    $nCent = -1;
    foreach ($aValues as $aValue) {
        if ($sValues == "") {
            $sValues = $aValue;
            $oCent = floor($aValue / 100);
        } else {
            $nCent = floor($aValue / 100);
            # TO DO: embed stations_recent URL
            if ($nCent != $oCent) {
                $sValues .= ", $aValue";
                $oCent = $nCent;
            } else {
                $sValues .= ",$aValue";
            }
        }
        #printf("<TR> <TD>-</td> <TD>%s</td> <TD>%d</td> <TD>%d</td> <TD>%s</td> </tr>\n", $aValue, $oCent, $nCent, $sValues);
    }

    printf("<TR> <TD>%s</td> <TD>%d</td> <TD>%s</td> </tr>\n", $key1, $nAantal, $sValues);
}
printf("<TR> <TD>all</td> <TD>%d</td> <TD>&nbsp;</td> </tr>\n", $nTotal);
printf("</table>\n");
printf("<A HREF=#top>top</a><br><br>\n");


$uEinde = time();
printf("%s:   page took %d seconds<br><br>\n", date("H:i:s"), $uEinde - $uBegin);

?>

    </body>
</html>
