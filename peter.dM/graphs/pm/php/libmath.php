<?php

# $Id: libmath.php $
# $Author: Peter Demmer for Meetjestad $

error_reporting(E_ALL);   // PHP


function ceiln($number, $significance = 1) {
    return ( is_numeric($number) && is_numeric($significance) ) ? (ceil($number/$significance)*$significance) : false;
}

function floorn($number, $significance = 1) {
    return ( is_numeric($number) && is_numeric($significance) ) ? (floor($number/$significance)*$significance) : false;
}


?>
