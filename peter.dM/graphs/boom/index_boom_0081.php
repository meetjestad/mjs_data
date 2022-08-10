<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
    <HEAD>
        <TITLE>mjs-boom-0081</title>
        <LINK HREF="../../style/meetjestad.css" REL="stylesheet" TYPE="text/css" MEDIA="all" />
    </head>
    <BODY>
        <A HREF=../../..>Meetjestad</a><P>
        <A HREF=..>Meetjestad graphs</a><P>
        <A HREF=.>Meetjestad tree trunk diameter graphs</a><P>
        <H1>Tree trunk diameter of node 81</h1>

        <A NAME=top></a>

        <A HREF=index_boom_0081.php>prev</a> &nbsp;
        <A HREF=../../data/sensors_recent.php?sensor=0081&limit=50>data</a> &nbsp;
        <A HREF=index_boom_0081.php>next</a><br><br>
        <P>

<?php
    // require 'php/lib_boom_func.php';

    $sPath = $_SERVER['SCRIPT_FILENAME'];
    $sNode = substr($sPath, -8, -4);
    #printf("node=%s<br>\n", $sNode);

    // print_calibration($sNode, "h");
?>
        Legenda:<br>
	<TABLE>
        <TR><TD>Function</td>               <TD>A displacement potentiometer is used to measure the tree trunk diameter over time</td></tr>
        <TR><TD>Tree species</td>           <TD>Esdoorn (Aceracea)</td></tr>
        <TR><TD>Trunk diameter formula</td> <TD>143.46 - 3.1442 * ((displacement/1024) * 10.0 + 28.4)</td></tr>
	<TR><TD>Trunk diameter unit</td>    <TD>cm</td></tr>
        <TR><TD>Temperature</td>            <TD>near the trunk, in Celcius</td></tr>
        <TR><TD>Rainfall</td>               <TD>incremental in mm, applying a 7-day absorbtion decay</td></tr>
	<TR><TD>Sunshine</td>               <TD>in Joule per cm<SUP>2</sup> per hour = 2.78 W / m<SUP>2</sub></td></tr>
        </table>
        <HR>

        <TABLE><TR><TD width=400>
            <!-- <A HREF=#t04d>measurements of the last 4 days</a><br> -->
            <A HREF=#t02w>measurements of the last 2 weeks</a><br>
            <A HREF=#t02m>measurements of the last 2 months</a><br>
            <A HREF=#t06m>measurements of the last 6 months</a><br>
            <!-- <A HREF=#t02y>measurements of the last 2 years</a> -->
	</td></tr></table>
        <br>
        <P>
        <HR>
<!--               
        <A NAME=t04d></a><B>Tree trunk diameter measurements of the last 4 days: &nbsp;&nbsp;&nbsp; </b>
        <A HREF=lst/mjs_boom_0081_ra_04d.lst>raw</a>&nbsp;&nbsp;&nbsp;
        <A HREF=lst/mjs_boom_0081_ca_04d.lst>calibrated</a>&nbsp;&nbsp;&nbsp;
        <A HREF=../knmi/lst/knmi_thdrs_04d.lst>knmi</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_boom_0081_t_04d.plt>diameter+temperature plot</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_boom_0081_m_04d.plt>sunshine+rain plot</a>&nbsp;&nbsp;&nbsp;<br>
        <IMG SRC=png/mjs_boom_0081_t_04d.png width=960 height=240><br><br>
	<IMG SRC=png/mjs_boom_0081_m_04d.png width=960 height=240><br><br>
        Soil moisture measurements from nearby station <A HREF=../bodem/index_bodem_2059.php>2059</a>:<br>
        <IMG SRC=../bodem/png/mjs_bodem_2059_m_04d.png width=960 height=240><br>
        <br>
        <HR>
-->   
        <A NAME=t02w></a><B>Tree trunk diameter measurements of the last 2 weeks: &nbsp;&nbsp;&nbsp; </b>
        <A HREF=lst/mjs_boom_0081_ra_02w.lst>raw</a>&nbsp;&nbsp;&nbsp;
        <A HREF=lst/mjs_boom_0081_ca_02w.lst>calibrated</a>&nbsp;&nbsp;&nbsp;
        <A HREF=../knmi/lst/knmi_thdrs_02w.lst>knmi</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_boom_0081_t_02w.plt>diameter+temperature plot</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_boom_0081_m_02w.plt>sunshine+rain plot</a>&nbsp;&nbsp;&nbsp;<br>
        <IMG SRC=png/mjs_boom_0081_t_02w.png width=960 height=240><br><br>
        <IMG SRC=png/mjs_boom_0081_m_02w.png width=960 height=240><br><br>
        Soil moisture measurements from nearby station <A HREF=../bodem/index_bodem_2059.php>2059</a>:<br>
        <IMG SRC=../bodem/png/mjs_bodem_2059_m_02w.png width=960 height=240><br>
        <br>
        <HR>
    
        <A NAME=t02m></a><B>Tree trunk diameter measurements of the last 2 months: &nbsp;&nbsp;&nbsp; </b>
        <A HREF=lst/mjs_boom_0081_ra_02m.lst>raw</a>&nbsp;&nbsp;&nbsp;
        <A HREF=lst/mjs_boom_0081_ca_02m.lst>calibrated</a>&nbsp;&nbsp;&nbsp;
        <A HREF=../knmi/lst/knmi_thdrs_02m.lst>knmi</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_boom_0081_t_02m.plt>diameter+temperature plot</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_boom_0081_m_02m.plt>sunshine+rain plot</a>&nbsp;&nbsp;&nbsp;<br>
        <IMG SRC=png/mjs_boom_0081_t_02m.png width=960 height=240><br><br>
        <IMG SRC=png/mjs_boom_0081_m_02m.png width=960 height=240><br><br>
        Soil moisture measurements from nearby station <A HREF=../bodem/index_bodem_2059.php>2059</a>:<br>
        <IMG SRC=../bodem/png/mjs_bodem_2059_m_02m.png width=960 height=240><br>
        <br>
        <HR>
    
        <A NAME=t06m></a><B>Tree trunk diameter measurements of the last 6 months: &nbsp;&nbsp;&nbsp; </b>
        <A HREF=lst/mjs_boom_0081_ra_06m.lst>raw</a>&nbsp;&nbsp;&nbsp;
        <A HREF=lst/mjs_boom_0081_ca_06m.lst>calibrated</a>&nbsp;&nbsp;&nbsp;
        <A HREF=../knmi/lst/knmi_thdrs_06m.lst>knmi</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_boom_0081_t_06m.plt>diameter+temperature plot</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_boom_0081_m_06m.plt>sunshine+rain plot</a>&nbsp;&nbsp;&nbsp;<br>
        <IMG SRC=png/mjs_boom_0081_t_06m.png width=960 height=240><br><br>
        <IMG SRC=png/mjs_boom_0081_m_06m.png width=960 height=240><br><br>
        Soil moisture measurements from nearby station <A HREF=../bodem/index_bodem_2059.php>2059</a>:<br>
        <IMG SRC=../bodem/png/mjs_bodem_2059_m_06m.png width=960 height=240><br>
        <br>
        <HR>
<!--
        <A NAME=t02y></a><B>Tree trunk diameter measurements of the last 2 years: &nbsp;&nbsp;&nbsp; </b>
        <A HREF=lst/mjs_boom_0081_ra_02y.lst>raw</a>&nbsp;&nbsp;&nbsp;
        <A HREF=lst/mjs_boom_0081_ca_02y.lst>calibrated</a>&nbsp;&nbsp;&nbsp;
        <A HREF=../knmi/lst/knmi_thdrs_02y.lst>knmi</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_boom_0081_t_02y.plt>diameter+temperature plot</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_boom_0081_m_02y.plt>sunshine+rain plot</a>&nbsp;&nbsp;&nbsp;<br>
        <IMG SRC=png/mjs_boom_0081_t_02y.png width=960 height=240><br><br>
        <IMG SRC=png/mjs_boom_0081_m_02y.png width=960 height=240><br><br>
        Soil moisture measurements from nearby station <A HREF=../bodem/index_bodem_2059.php>2059</a>:<br>
        <IMG SRC=../bodem/png/mjs_bodem_2059_m_02y.png width=960 height=240<br>
        <br>
        <br>
        </b>
-->
        <A HREF=#top>top</a><br>
    </body>
</html>
