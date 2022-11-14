<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
    <HEAD>
        <TITLE>mjs-greenroof-2088</title>
        <LINK HREF="../../style/meetjestad.css" REL="stylesheet" TYPE="text/css" MEDIA="all" />
    </head>
    <BODY>
        <A HREF=../../..>Meet je Stad</a><P>
        <A HREF=..>Meet je Stad graphs</a><P>
        <A HREF=.>Meet je Stad green roof graphs</a><P>
        <H1>Green roof measurements of node 2088</h1>

        <A NAME=top></a>

        <A HREF=index_greenroof_2086.php>2086</a> &nbsp; 
        <A HREF=../../data/sensors_recent.php?sensor=2088&limit=50>raw data</a> &nbsp; 
        <A HREF=index_greenroof_2089.php>2089</a>
        <P>

<?php
    require 'php/lib_greenroof_func.php';

    $sPath = $_SERVER['SCRIPT_FILENAME'];
    $sNode = substr($sPath, -8, -4);
    #printf("node=%s<br>\n", $sNode);

    print_calibration($sNode, "h");
?>

        <HR>
        <TABLE><TR><TD width=400>
            <A HREF=#t02w>measurements of the last 2 weeks</a><br>
            <A HREF=#t02m>measurements of the last 2 months</a><br>
            <A HREF=#t06m>measurements of the last 6 months</a><br>
            <!-- <A HREF=#t02y>measurements of the last 2 years</a> -->
        </td></tr></table>
        <P>
        <HR>

        <br>
	<A NAME=t02w></a><B>Green roof measurements of the last 2 weeks</b>: <br>
        Data: &nbsp; 
        <A HREF=lst/mjs_greenroof_2088_ra_02w.lst>raw</a> &nbsp; 
        <A HREF=lst/mjs_greenroof_2088_ca_02w.lst>calibrated</a> &nbsp; 
        <A HREF=../knmi/lst/knmi_thdrsR_260_02w.lst>knmi</a> &nbsp; 
        Plots: &nbsp; 
        <A HREF=plt/mjs_greenroof_2088_te_02w.plt>temperature+sunshine plot</a> &nbsp; 
        <A HREF=plt/mjs_greenroof_2088_hu_02w.plt>rainfall+roof humidity plot</a><br>
        <IMG SRC=png/mjs_greenroof_2088_te_02w.png width=960 height=240>
        <IMG SRC=png/mjs_greenroof_2088_hu_02w.png width=960 height=240><br>
        <br>
        <HR>

        <br>
        <A NAME=t02m></a><B><B>Green roof measurements of the last 2 months</b>: <br>
        Data: &nbsp; 
        <A HREF=lst/mjs_greenroof_2088_ra_02m.lst>raw</a> &nbsp; 
        <A HREF=lst/mjs_greenroof_2088_ca_02m.lst>calibrated</a> &nbsp; 
        <A HREF=../knmi/lst/knmi_thdrsR_260_02m.lst>knmi</a> &nbsp; 
        Plots: &nbsp; 
        <A HREF=plt/mjs_greenroof_2088_te_02m.plt>temperature+sunshine plot</a> &nbsp; 
        <A HREF=plt/mjs_greenroof_2088_hu_02m.plt>rainfall+roof humidity plot</a><br>
        <IMG SRC=png/mjs_greenroof_2088_te_02m.png width=960 height=240>
        <IMG SRC=png/mjs_greenroof_2088_hu_02m.png width=960 height=240><br>
        <br>
        <HR>
    
        <br>
        <A NAME=t06m></a><B>Green roof measurements of the last 6 months</b>: <br>
        Data: &nbsp; 
        <A HREF=lst/mjs_greenroof_2088_ra_06m.lst>raw</a> &nbsp; 
        <A HREF=lst/mjs_greenroof_2088_ca_06m.lst>calibrated</a> &nbsp; 
	<A HREF=../knmi/lst/knmi_thdrsR_260_06m.lst>knmi</a> &nbsp; 
        Plots: &nbsp; 
        <A HREF=plt/mjs_greenroof_2088_te_06m.plt>temperature+sunshine plot</a> &nbsp; 
        <A HREF=plt/mjs_greenroof_2088_hu_06m.plt>rainfall+roof humidity plot</a><br>
        <IMG SRC=png/mjs_greenroof_2088_te_06m.png width=960 height=240>
        <IMG SRC=png/mjs_greenroof_2088_hu_06m.png width=960 height=240><br>
        <br>
        <HR>
<!--
        <br>
        <A NAME=t02y></a><B>Green roof measurements of the last 2 years</b>: <br>
        Data: &nbsp; 
        <A HREF=lst/mjs_greenroof_2088_ra_02y.lst>raw</a> &nbsp; 
        <A HREF=lst/mjs_greenroof_2088_ca_02y.lst>calibrated</a> &nbsp; 
        <A HREF=../knmi/lst/knmi_thdrsR_260_02y.lst>knmi</a> &nbsp; 
        Plots: &nbsp; 
        <A HREF=plt/mjs_greenroof_2088_te_02y.plt>temperature+sunshine plot</a> &nbsp; 
        <A HREF=plt/mjs_greenroof_2088_hu_02y.plt>rainfall+roof humidity plot</a><br>
        <IMG SRC=png/mjs_greenroof_2088_te_02y.png width=960 height=240>
        <IMG SRC=png/mjs_greenroof_2088_hu_02y.png width=960 height=240><br>
        <br>
        <br>
        </b>
-->
        <A HREF=#top>top</a><br>
    </body>
</html>
