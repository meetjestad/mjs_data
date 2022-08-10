<?php

# $Id: libdewp.php $
# $Author: Peter Demmer for Meetjestad $

error_reporting(E_ALL);   // PHP


function TempDewp2relHumi($fTd, $fTw) {
    # Ref: http://www.1728.org/relhum.htm
    # Td = Dry Bulb Temperature  (in C)
    # Tw = Wet Bulb Temperature (dewpoint) (in C)
    # RH = relative humidity in %
    # Test: Td = 20. C, Tw = 15. C => RH = 58.4 %

    #$fE = 2.718281828;
    $fN = .6687451584;

    $fEd = 6.112 * exp((17.502 * $fTd) / (240.97 + $fTd));
    $fEw = 6.112 * exp((17.502 * $fTw) / (240.97 + $fTw));

    $fRH = ($fEw - $fN * (1. + .00115 * $fTw) * ($fTd - $fTw)) * 100. / $fEd;

    return $fRH;
}


function TempRelHumi2dewp($fTd, $fRH) {
    # Ref: http://www.1728.org/dewpoint.htm
    # Td = Dry Bulb Temperature  (in C)
    # RH = relative humidity in %
    # Tw = Wet Bulb Temperature (dewpoint) (in C)
    # Test: Td = 20. C, RH = 50. % => dewpoint = 9.27 C

    #$fE = 2.718281828;

    $fN = (log($fRH/100.) + ((17.27 * $fTd) / (237.3 + $fTd))) / 17.27;
    $fTw = (237.3 * $fN) / (1 - $fN);

    return $fTw;
}


?>
