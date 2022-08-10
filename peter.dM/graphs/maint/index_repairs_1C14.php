<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!-- $Id: meetjestad.net/static/graphs/maint/maint_repairs_1C14.php $ -->
<!-- $Author: Peter Demmer for Meetjestad! $ -->

<HTML>
    <HEAD>
        <TITLE>maint/repairs</title>
		<LINK HREF="../../style/meetjestad.css" REL="stylesheet" TYPE="text/css" MEDIA="all" />
		<LINK HREF="maint.css" REL="stylesheet" TYPE="text/css" MEDIA="all" />
	    </head>
	    <BODY>
		<A HREF=../../..>Meet je Stad</a><P>
		<A HREF=..>Meet je Stad graphs</a><P>
		<A HREF=.>Meet je Stad maintenance</a><P>
		<A NAME=top></a>
		<H2>Battery voltage of stations repaired 14 Dec. '21:</h2>
		<br>

		<A HREF=#t02w>Activity of the last 2 weeks</a><br>
		<A HREF=#t02m>Activity of the last 2 months</a><br>
		<br>
		<br>
			
		
<?php

# $Id: meetjestad.net/static/graphs/maint/index_repairs_1C14.php $
# $Author: Peter Demmer for Meetjestad! $

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');

function epoch2ago(int $iUnixtime) {
    $iNow = time();
    $iAgo = $iNow - $iUnixtime;
    $iDays = floor($iAgo / 86400);
    $iHours = floor($iAgo / 3600);
    $iHours %= 24;
    $iMinutes = floor($iAgo / 60);
    $iMinutes %= 60;
    $sRet = "";
    if ($iDays != 0) $sRet .= sprintf("%dd", $iDays);
    if ($iHours != 0) $sRet .= sprintf("%dh", $iHours);
    if ($iDays < 1 and $iMinutes != 0) $sRet .= sprintf("%dm", $iMinutes);
    if ($iDays == 0 and $iHours == 0 and $iMinutes == 0) {
        $sRet = "now";
    } else {
        $sRet .= " ago";
    }
    return ($sRet);
}


$aiStation = array(60, 63, 81, 104, 106, 167, 293, 297, 514, 653, 654);
$aPer = array('02w', '02m');
$aPeriode = array('02w' => '2 weeks', '02m' => '2 months');

foreach($aPer as $sPer) {
    $sPeriod = $aPeriode[$sPer];
    #printf("Per=$sPer Periode=$sPeriod<br>\n");

    printf("<TABLE BORDER=1>\n");
    printf("<TR><TH>station</th> ");
    printf("<TH>battery<br>voltage</th> ");
    printf("<TH>first time<br>seen</th> ");
    printf("<TH>last time<br>seen</th> ");
    printf("<TH COLSPAN=2>measurements<br>received</th> ");
    printf("<TH>last<br>updated</th></tr>\n");
    foreach ($aiStation as $iStation) {
        $sStation = sprintf("%04d", $iStation);
        printf("<TR>\n");
        printf("<TD>$iStation</td> ");
    
        $fMeta = sprintf("lst/mjs_repair_%s_met_%s.json", $sStation, $sPer);
        $jsMeta = file_get_contents($fMeta);
        $aMeta = json_decode($jsMeta, true);
    
        printf("<TD>%s ... ", $aMeta['first_battery_voltage_mV']);
        printf("%s mV</td> ", $aMeta['last_battery_voltage_mV']);
        $iNOvbv = (int) $aMeta['no_valid_battery_voltages'];
        $iFTA = (int) $aMeta['first_time_active'];
        $iLTA = (int) $aMeta['last_time_active'];
        printf("<TD>%s</td> ", epoch2ago($iFTA));
        printf("<TD>%s</td> ", epoch2ago($iLTA));
        printf("<TD>%d</td> ", $iNOvbv);
        printf("<TD>%.1f%%</td> ", 100. * $iNOvbv * 900. / ($iLTA - $iFTA));
        printf("<TD>%s</td> ", epoch2ago($aMeta['last_updated']));
    
        printf("</tr>\n");
    }
    printf("</table>\n");
    if ($sPer == '02w') printf("<B>Note:</b> 2-weeks updates are done every 2 hours at :11<br><br>\n");
    if ($sPer == '02m') printf("<B>Note:</b> 2-months updates are done daily at 0:12<br><br>\n");
    
    printf("<A NAME=t%s></a>Station activity of the last %s:<br>\n", $sPer, $sPeriod);
    printf("<IMG SRC=png/mjs_repairs_1C14_%s.png width=960 height=240><br>\n", $sPer);
    printf("Source data:&nbsp;&nbsp;\n");
    
    foreach ($aiStation as $iStation) {
        $sStation = sprintf("%04d", $iStation);
        printf("<A HREF=lst/mjs_repair_%s_raw_%s.lst>%d</a>&nbsp;&nbsp;\n", $sStation, $sPer, $iStation);
    }
    printf("<br>Calibrated data:&nbsp;&nbsp;\n");
    foreach ($aiStation as $iStation) {
        $sStation = sprintf("%04d", $iStation);
        printf("<A HREF=lst/mjs_repair_%s_cal_%s.lst>%d</a>&nbsp;&nbsp;\n", $sStation, $sPer, $iStation);
    }
    printf("<br><A HREF=plt/mjs_repairs_1C14_%s.plt>Plot</a><br><br>\n", $sPer);
    printf("</font>\n");
    printf("<P>\n");
}

?>

	<A HREF=#top>top</a><br>
    </body>
</html>
