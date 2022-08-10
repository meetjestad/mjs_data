<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
    <HEAD>
        <TITLE>graphs/repairs</title>
		<LINK HREF="../../style/meetjestad.css" REL="stylesheet" TYPE="text/css" MEDIA="all" />
		<LINK HREF="fhum2.css" REL="stylesheet" TYPE="text/css" MEDIA="all" />
	    </head>
	    <BODY>
		<A HREF=../../..>index Meet je Stad</a><P>
		<A HREF=..>index Meet je Stad graphs</a><P>
		<A HREF=.>index Meet je Stad humidity measurements graphs</a><P>
		<A NAME=top></a>
		<H2>Heated and unheated cabinet measurements</h2>
		<br>
                <br>
                <B>Legenda:</b><br>
                <TABLE>
                <TR><TD>mjs-68</td><TD>heated station</td></tr>
                <TR><TD>mjs-176</td><TD>unheated station</td></tr>
                <TR><TD>KNMI-290</td><TD>nearest National Weather Institute station</td></tr>
                </table>
                <br><br>
			
		
<?php
error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');


$aiStation = array(68, 176);
$aPer = array('04d', '02w', '02m');
$aPeriode = array('04d' => '4 days', '02w' => '2 weeks', '02m' => '2 months');

foreach($aPer as $sPer) {
    $sPeriod = $aPeriode[$sPer];
    printf("<A HREF=#t%s>The last %s<br>\n", $sPer, $sPeriod);
}
printf("<br><br>\n");

foreach($aPer as $sPer) {
    $sPeriod = $aPeriode[$sPer];
    
    printf("<A NAME=t%s></a>Measurements of the last %s:<br>\n", $sPer, $sPeriod);
    printf("<IMG SRC=png/mjs_fhum2_2_%s.png width=960 height=240><br><br>\n", $sPer);
    printf("Raw data:\n");
    foreach ($aiStation as $iStation) {
        $sStation = sprintf("%04d", $iStation);
        printf("<A HREF=lst/mjs_fhum2_%s_raw_%s.lst>%d</a>&nbsp;&nbsp;\n", $sStation, $sPer, $iStation);
    }
    printf("&nbsp;&nbsp;&nbsp;Calibrated data:\n");
    foreach ($aiStation as $iStation) {
        $sStation = sprintf("%04d", $iStation);
        printf("<A HREF=lst/mjs_fhum2_%s_cal_%s.lst>%d</a>&nbsp;&nbsp;\n", $sStation, $sPer, $iStation);
    }
    printf("&nbsp;&nbsp;&nbsp;<A HREF=../knmi/lst/knmi_thdrs_260_%s.lst>KNMI</a>\n", $sPer);
    printf("&nbsp;&nbsp;&nbsp;<A HREF=plt/mjs_fhum2_2_%s.plt>Plot</a><br><br>\n", $sPer);
    printf("<P>\n");
}

?>

	<A HREF=#top>top</a><br>
    </body>
</html>
