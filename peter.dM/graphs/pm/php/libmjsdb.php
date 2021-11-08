<?php

# $Id:$


# SELECT queries:
function  libqueryr($sQuery) {
    $aaResult = array();

    $rDB = mysqli_connect('127.0.0.1', 'mjs_lees', 'mjs_lees')
        or die('mysqli: Could not connect to localhost as mjs_lees: ' . mysqli_error($rDB));

    mysqli_select_db($rDB, 'mjs_data')
        or die('mysqli: Could not select mjs_data database: ' . mysqli_error($rDB));

    $rResult = mysqli_query($rDB, $sQuery)
        or die("Query failed: " . mysqli_error($rDB) . "\n");

    while ($rRow = mysqli_fetch_array($rResult, MYSQLI_NUM)) {
        $nCol = sizeof($rRow);
        $aCols = array();
        for ($iCol = 0; $iCol < $nCol; $iCol++) {
            $aCols[] = $rRow[$iCol];
        }
        $aaResult[] = $aCols;
    }

    mysqli_close($rDB);

    return $aaResult;
};


# INSERT, REPLACE or UPDATE queries:
function libqueryw($sQuery) {
    $aaResult = array(array());

    $rDB = mysqli_connect('127.0.0.1', 'mjs_data', 'supergeheim')
        or die('mysqli: Could not connect to localhost as mjs_data: ' . mysqli_error($rDB));

    mysqli_select_db($rDB, 'mjs_data')
        or die('mysqli: Could not write to mjs_data database: ' . mysqli_error($rDB));

    $rResult = mysqli_query($rDB, $sQuery)
        or die("Query failed: " . mysqli_error($rDB) . "\n");

    /* typically an INSERT, REPLACE or UPDATE query does not retreive data:
    while ($rRow = mysqli_fetch_array($rResult, MYSQLI_NUM)) {
        $nCol = sizeof($rRow);
        $aCols = array();
        for ($iCol = 0; $iCol < $nCol; $iCol++) {
            $aCols[] = $rRow[$iCol];
        }
        $aaResult[] = $aCols;
    }
    */

    mysqli_close($rDB);

    return $aaResult;
};


?>
