<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
    <HEAD>
        <TITLE>mjs-bodem-2085</title>
        <LINK HREF="../../style/meetjestad.css" REL="stylesheet" TYPE="text/css" MEDIA="all" />
    </head>
    <BODY>
        <A HREF=../../..>Meetjestad!</a><P>
        <A HREF=..>Meetjestad! graphs</a><P>
        <A HREF=.>Meetjestad! soil moisture</a><P>
        <H1>soil moisture measurements of station 2085</h1>

        <A NAME=top></a>

        <A HREF=index_bodem_2084.php>2084</a> &nbsp;
        <A HREF=../../data/sensors_recent.php?sensor=2085&limit=50>data</a> &nbsp;
        <A HREF=index_bodem_2085.php>2085</a><br><br>
        <P>

<?php
    require 'php/lib_bodem_func.php';

    $sPath = $_SERVER['SCRIPT_FILENAME'];
    $sNode = substr($sPath, -8, -4);
    #printf("station=%s<br>\n", $sNode);

    print_calibration($sNode, "h");
?>

        <TABLE><TR><TD width=400>
            <A HREF=#t04d>measurements of the last 4 days</a><br>
            <A HREF=#t02w>measurements of the last 2 weeks</a><br>
            <A HREF=#t02m>measurements of the last 2 months</a><br>
            <A HREF=#t06m>measurements of the last 6 months</a><br>
            <!-- <A HREF=#t02y>measurements of the last 2 years</a> -->
        </td></tr></table>
        <P>
        <HR>
               
	<br>
        <A NAME=t04d></a><B>Soil moisture measurements of the last 4 days: &nbsp;&nbsp;&nbsp; </b><br>
        Data: &nbsp; 
        <A HREF=lst/mjs_bodem_2085_ra_04d.lst>raw</a>&nbsp;&nbsp;&nbsp;
        <A HREF=lst/mjs_bodem_2085_ca_04d.lst>calibrated</a>&nbsp;&nbsp;&nbsp;
        <A HREF=../knmi/lst/knmi_thdrsR_260_04d.lst>knmi</a>&nbsp;&nbsp;&nbsp;
        Plots: &nbsp; 
        <A HREF=plt/mjs_bodem_2085_m_04d.plt>moisture plot</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_bodem_2085_t_04d.plt>temperature plot</a><br>
        <IMG SRC=png/mjs_bodem_2085_m_04d.png width=960 height=240><br>
        <IMG SRC=png/mjs_bodem_2085_t_04d.png width=960 height=240>
        <br>
        <HR>
    
        <br>
        <A NAME=t02w></a><B>Soil moisture measurements of the last 2 weeks: &nbsp;&nbsp;&nbsp; </b><br>
        Data: &nbsp; 
        <A HREF=lst/mjs_bodem_2085_ra_02w.lst>raw</a>&nbsp;&nbsp;&nbsp;
        <A HREF=lst/mjs_bodem_2085_ca_02w.lst>calibrated</a>&nbsp;&nbsp;&nbsp;
        <A HREF=../knmi/lst/knmi_thdrsR_260_02w.lst>knmi</a>&nbsp;&nbsp;&nbsp;
        Plots: &nbsp; 
        <A HREF=plt/mjs_bodem_2085_m_02w.plt>moisture plot</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_bodem_2085_t_02w.plt>temperature plot</a><br>
        <IMG SRC=png/mjs_bodem_2085_m_02w.png width=960 height=240><br>
        <IMG SRC=png/mjs_bodem_2085_t_02w.png width=960 height=240>
        <br>
        <HR>
    
        <br>
        <A NAME=t02m></a><B>Soil moisture measurements of the last 2 months: &nbsp;&nbsp;&nbsp; </b><br>
        Data: &nbsp; 
        <A HREF=lst/mjs_bodem_2085_ra_02m.lst>raw</a>&nbsp;&nbsp;&nbsp;
        <A HREF=lst/mjs_bodem_2085_ca_02m.lst>calibrated</a>&nbsp;&nbsp;&nbsp;
        <A HREF=../knmi/lst/knmi_thdrsR_260_02m.lst>knmi</a>&nbsp;&nbsp;&nbsp;
        Plots: &nbsp; 
        <A HREF=plt/mjs_bodem_2085_m_02m.plt>moisture plot</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_bodem_2085_t_02m.plt>temperature plot</a><br>
        <IMG SRC=png/mjs_bodem_2085_m_02m.png width=960 height=240><br>
        <IMG SRC=png/mjs_bodem_2085_t_02m.png width=960 height=240>
        <br>
        <HR>
    
        <br>
        <A NAME=t06m></a><B>Soil moisture measurements of the last 6 months: &nbsp;&nbsp;&nbsp; </b><br>
        Data: &nbsp; 
        <A HREF=lst/mjs_bodem_2085_ra_06m.lst>raw</a>&nbsp;&nbsp;&nbsp;
        <A HREF=lst/mjs_bodem_2085_ca_06m.lst>calibrated</a>&nbsp;&nbsp;&nbsp;
        <A HREF=../knmi/lst/knmi_thdrsR_260_06m.lst>knmi</a>&nbsp;&nbsp;&nbsp;
        Plots: &nbsp; 
        <A HREF=plt/mjs_bodem_2085_m_06m.plt>moisture plot</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_bodem_2085_t_06m.plt>temperature plot</a><br>
        <IMG SRC=png/mjs_bodem_2085_m_06m.png width=960 height=240><br>
        <IMG SRC=png/mjs_bodem_2085_t_06m.png width=960 height=240>
        <br>
        <HR>
<!--
        <br>
        <A NAME=t02y></a><B>Soil moisture measurements of the last 2 years: &nbsp;&nbsp;&nbsp; </b><br>
        Data: &nbsp; 
        <A HREF=lst/mjs_bodem_2085_ra_02y.lst>raw</a>&nbsp;&nbsp;&nbsp;
        <A HREF=lst/mjs_bodem_2085_ca_02y.lst>calibrated</a>&nbsp;&nbsp;&nbsp;
        <A HREF=../knmi/lst/knmi_thdrsR_260_02y.lst>knmi</a>&nbsp;&nbsp;&nbsp;
        Plots: &nbsp; 
        <A HREF=plt/mjs_bodem_2085_m_02y.plt>moisture plot</a>&nbsp;&nbsp;&nbsp;
        <A HREF=plt/mjs_bodem_2085_t_02y.plt>temperature plot</a><br>
        <IMG SRC=png/mjs_bodem_2085_m_02y.png width=960 height=240><br>
        <IMG SRC=png/mjs_bodem_2085_t_02y.png width=960 height=240>
        <br>
        <br>
        </b>
-->
        <A HREF=#top>top</a><br>
    </body>
</html>
