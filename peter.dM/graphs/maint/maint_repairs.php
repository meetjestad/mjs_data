<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!-- $Id: meetjestad.net/static/graphs/maint/maint_repairs.php $ -->
<!-- $Author: Peter Demmer for Meetjestad! $ -->

<!-- Note: there is already: https://meetjestad.nl/static/data/sensors_json.php?select=gone&start=...  -->
<!-- but how to specify start is unknown to me -->


<HTML>
    <HEAD>
        <TITLE>maint/repairs</title>
                <LINK HREF="../../style/meetjestad.css" REL="stylesheet" TYPE="text/css" MEDIA="all" />
                <LINK HREF="maint.css" REL="stylesheet" TYPE="text/css" MEDIA="all" />
            </head>
            <BODY>
                <A HREF=../../..>Meet je Stad!</a><P>
                <A HREF=..>Meet je Stad! graphs</a><P>
                <A HREF=.>Meet je Stad! maintenance</a><P>
                <A NAME=top></a>

                
<?php

error_reporting(E_ALL);   // PHP
date_default_timezone_set('Europe/Amsterdam');
require_once ("libmaint.php");


function epoch2ago(int $iUnixtime) {
    global $bDeb;

    if ($iUnixtime <= 0) return ("-");

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
        $sRet = "0m";
    }

    if ($bDeb) printf("%d   Unixtime=$iUnixtime ago=$sRet<br>\n", __LINE__);
    return ($sRet);
}


# main()   --------------------------------------------------------------------


$uBegin = time();

$bDeb = false;

$aiStation = array(755);
if (isset($_GET['station'])) {
    $liStation = $_GET['station'];
    $aiStation = explode(',', $liStation);
}

$aPer = array('04d', '02w', '02m', '06m');
#$aPer = array('04d', '02w', '02m');
#$aPer = array('04d', '02w');
#$aPer = array('04d');
$aPeriod = array('04d' => '4 days', '02w' => '2 weeks', '02m' => '2 months', '06m' => '6 months');

printf("<H2>Status of repaired stations %s</h2>\n", implode(", ", $aiStation));
#printf("Listed %s \n", date("H:i:s"));
printf("<A HREF=maint_repairs.php?station=%s>Refreshed</a> %s<br><br>\n", implode(",", $aiStation), date("H:i:s"));

foreach($aPer as $sPer) {
    $sPeriod = $aPeriod[$sPer];
    printf("<A HREF=#t%d>Activity of the last %s</a><br>\n", $sPer, $sPeriod);
}
printf("<br><br>\n");


foreach($aPer as $sPer) {
    $sPeriod = $aPeriod[$sPer];
    printf("<B>Over the last %s:</b><br>\n", $sPeriod);

    printf("<TABLE BORDER=1>\n");
    printf("<TR><TH>station</th> ");
    printf("<TH>battery<br>voltage</th> ");
    printf("<TH>first<br>seen</th> ");
    printf("<TH>last<br>boot</th>\n");
    printf("<TH>last<br>seen</th> ");
    printf("<TH>last<br>f_cnt</th>\n");
    printf("<TH COLSPAN=2># <br>measurements</th>\n");
    #printf("<TH COLSPAN=2># battery<br>measurements</th>\n");
    printf("<TH>#<br>restarts</th>\n");
    printf("</tr>\n");

    $uStart = time();
    foreach ($aiStation as $iStation) {
        $sStation = sprintf("%04d", $iStation);
        if ($bDeb) printf("%d   Per=$sPer Periode=$sPeriod iStation=$iStation sStation=$sStation<br>\n", __LINE__);

        $aMaintdata = getmaintdata($iStation, $sPer);
        $jsReturn = $aMaintdata[0];
        $aaReturn = $aMaintdata[1];
        $aMeta = json_decode($jsReturn, true);
        if ($bDeb) printf("json=$jsReturn<br>\n");

        printf("<TR>\n");
        printf("<TD>$iStation</td> ");
        $bNoBatt = ($aMeta['first_battery_voltage_mV'] == 0 or $aMeta['last_battery_voltage_mV'] == 0);
        if ($bNoBatt) {
            printf("<TD>&nbsp;</td> ");
        } else {
            printf("<TD>%s ... ", $aMeta['first_battery_voltage_mV']);
            printf("%s mV</td> ", $aMeta['last_battery_voltage_mV']);
        }

        $uFTA = (int) $aMeta['first_time_active'];
        if ($uFTA <= 0) {
            printf("<TD>-</td> ");
        } else { 
            printf("<TD>%s ago</td> ", epoch2ago($uFTA));
	}

        $uBoot = $aMeta['last_boot'];
        $sUptime = epoch2ago($uBoot);
        printf("<TD>%s ago</td> ", $sUptime);

        $uLTA = (int) $aMeta['last_time_active'];
        if ($uLTA <= 0) {
            printf("<TD>-</td> ");
        } else {
            printf("<TD>%s ago</td> ", epoch2ago($uLTA));
        }

        $iLFC = (int) $aMeta['last_f_cnt'];
        if ($iLFC < 0) {
            printf("<TD>&nbsp;</td> ");
        } else {
            printf("<TD>%d</td> ", $iLFC);
        }

        $iNumber = (int) $aMeta['no_measurements'];
        printf("<TD>%d</td> ", $iNumber);
        if ($uLTA == $uFTA) {
            printf("<TD>&nbsp;</td> ");
        } else {
            printf("<TD>%.1f%%</td> ", 100. * $iNumber * 900. / ($uLTA - $uFTA));
	}

        #$iNOvbv = (int) $aMeta['no_valid_battery_voltages'];
        #if ($bNoBatt) {
            #printf("<TD COLSPAN=2>&nbsp;</td> ");
        #} else {
            #printf("<TD>%d</td> ", $iNOvbv);
            #printf("<TD>%.1f%%</td> ", 100. * $iNOvbv * 900. / ($uLTA - $uFTA));
        #}

        printf("<TD>%d</td> ", (int) $aMeta['no_f_cnt_0']);
        printf("</tr>\n");
        $bDeb = false;
    }
    printf("</table>\n");
    $uEinde = time();
    printf("%d queries took %d seconds<br>\n", count($aiStation), $uEinde - $uStart);
    printf("<P>\n");
}

$uEinde = time();
printf("%s:   page took %d seconds<br><br>\n", date("H:i:s"), $uEinde - $uBegin);

?>

        <A HREF=#top>top</a><br>
    </body>
</html>

