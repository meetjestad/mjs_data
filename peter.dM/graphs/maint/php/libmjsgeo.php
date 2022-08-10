<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!-- $Id: meetjestad.net/static/graphs/maint/php/libmjsgeo.php $ -->
<!-- $Author: Peter Demmer for Meetjestad! $ -->


<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');


# Ref: https://stackoverflow.com/questions/10053358/measuring-the-distance-between-two-coordinates-in-php
function circle_distance($lat1, $lon1, $lat2, $lon2) {
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


function rhumbLineBearing($lat1, $lon1, $lat2, $lon2) {
    // Ref: https://stackoverflow.com/questions/2859867/relative-position-in-php-between-2-points-lat-long

    //difference in longitudinal coordinates
    $dLon = deg2rad($lon2) - deg2rad($lon1);

    //difference in the phi of latitudinal coordinates
    $dPhi = log(tan(deg2rad($lat2) / 2 + M_PI / 4) / tan(deg2rad($lat1) / 2 + M_PI / 4));

    //we need to recalculate $dLon if it is greater than pi
    if(abs($dLon) > M_PI) {
        if($dLon > 0) {
            $dLon = (2 * M_PI - $dLon) * -1;
        }
        else {
            $dLon = 2 * M_PI + $dLon;
        }
    }
    //return the angle, normalized
    return (rad2deg(atan2($dLon, $dPhi)) + 360) % 360;
}


function compassDirection($fBearing) {
    # Bearing in degrees
    static $cardinals = array( 'N ', 'NE', 'E ', 'SE', 'S ', 'SW', 'W ', 'NW', 'N ' );
    return $cardinals[round( $fBearing / 45. )];
}


function getGeo($sStation) {
    global $lDeb;

    $sQuery2 = "SELECT timestamp, latitude, longitude FROM sensors_measurement WHERE station_id = $sStation AND longitude NOT IN (0, -1) AND latitude NOT IN (0, -1)  ORDER BY timestamp DESC LIMIT 1";
    if ($lDeb > 0) printf("sQuery2='$sQuery2'\n");
    $aaResult2 = queryr($sQuery2);
    $sTimestamp = "";
    $sLatitude = "0.";
    $sLongitude = "0.";
    foreach ($aaResult2 as $aRow2) { 
        $sTimestamp = $aRow2[0];
        $sLatitude = $aRow2[1];
        $sLongitude = $aRow2[2];
    }
    $fLatitude = (float) $sLatitude;
    $fLongitude = (float) $sLongitude;
    $afDistance = array();
    $afBearing = array();
    $aLoc = array();
    $aLoc['Ah']     = array('Lat' => 51.9856891, 'Lon' => 5.8991826);
    $aLoc['Amf']    = array('Lat' => 52.1563226, 'Lon' => 5.3885627);
    #$aLoc['Amf_gd'] = array('Lat' => 52.1626766, 'Lon' => 5.3768578);
    #$aLoc['Amf_hb'] = array('Lat' => 52.1540489, 'Lon' => 5.3976293);
    $aLoc['Apd']    = array('Lat' => 52.2096407, 'Lon' => 5.9691551);
    $aLoc['Bg']     = array('Lat' => 60.3966726, 'Lon' => 5.3247978);
    $aLoc['Ehv']    = array('Lat' => 51.4433210, 'Lon' => 5.4793703);
    $aLoc['Es']     = array('Lat' => 52.2206837, 'Lon' => 6.8956346);
    #$aLoc['Khv']    = array('Lat' => 51.6565298, 'Lon' => 5.0325466);
    $aLoc['Tb']     = array('Lat' => 51.5650189, 'Lon' => 5.0511252);
    $aLoc['Ut']     = array('Lat' => 52.0908837, 'Lon' => 5.1213506);
    foreach ($aLoc as $key => $value) {
        $afDistance[$key] = circle_distance($fLatitude, $fLongitude, $aLoc[$key]['Lat'], $aLoc[$key]['Lon']);
        $afBearing[$key] = rhumbLineBearing($aLoc[$key]['Lat'], $aLoc[$key]['Lon'], $fLatitude, $fLongitude);
    }
    #$sRegion = sprintf("%.1f  %.1f  %.1f  %.1f   ", $afDistance['Amf'], $afDistance['Bg'], $afDistance['Tb'], $afDistance['Ut']);
    asort($afDistance);
    $sRegion1 = array_first_key($afDistance);
    $fDistance1 = $afDistance[$sRegion1];
    $fBearing1 = $afBearing[$sRegion1];
    $sDirection1 = compassDirection($fBearing1);
    $sRegion = 'onbekend';
    if ((float) $fDistance1 > 100.) {
        $sRegion = sprintf("&nbsp;");
        $sDirect = sprintf("&nbsp;");
    } else {
        $sRegion = sprintf("%s", $sRegion1);
        if ($fDistance1 >= 1.) {
            $sDirect = sprintf("%.1fkm %s", $fDistance1, $sDirection1);
        } else {
                $sDirect = sprintf("%.0fm %s", $fDistance1 * 1000., $sDirection1);
        }
    }

    return array($sTimestamp, $sLatitude, $sLongitude, $sRegion, $sDirect);
}


?>
