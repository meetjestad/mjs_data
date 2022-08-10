<?php


function print_calibration($sNode, $eMode = "") {
    $lDeb = 0;

    if ($lDeb > 0) printf("print_calibration: Node=%s Mode='%s'\n", $sNode, $eMode);

    $sJson = "";
    if (file_exists('cal_bodem.json'))    $sJson = file_get_contents("cal_bodem.json");      # running from index directory
    if (file_exists('../cal_bodem.json')) $sJson = file_get_contents("../cal_bodem.json");   # running from php directory
    if ($sJson == "") {
        printf("cal_bodem.json not found, abort<br>\n");
        exit(1);
    }

    $aaCal = json_decode($sJson, true);
    $aRowNode = false;
    $aRowDflt = false;
    $aRowRslt = false;
    foreach ($aaCal as $aRow) {
        if ($aRow['id'] == $sNode) {
            $aRowNode = $aRow;
        }
        if ($aRow['id'] == "default") {
            $aRowDflt = $aRow;
        }
    }

    if ($aRowNode !== false) {
        $aRowRslt = $aRowNode;
    } else {
        if ($aRowDflt !== false) {
            $aRowRslt = $aRowDflt;
        } else {
            if ($eMode == "h") {
                printf("<A HREF=cal_bodem.json>json</a> error: node %s not found and default not found: no calibration<br>\n", $sNode);
                return array(false, false, false, false, false, false);
            }
        }
    }
    if ($lDeb > 1) {
        printf("42 RowRslt=");
        print_r($aRowRslt);
        printf("\n");
    }

    $s='&nbsp;';
    if ($aRowRslt !== false) {
        $iSoilM1 = (int) $aRowRslt['format']['soilM10'];
        $iSoilT1 = (int) $aRowRslt['format']['soilT10'];
        $iSoilM2 = (int) $aRowRslt['format']['soilM40'];
        $iSoilT2 = (int) $aRowRslt['format']['soilT40'];
        $sSoilSoil   = $aRowRslt['location']['soil'];
        $sSoilDepths = $aRowRslt['location']['depths'];
        if ($eMode == "h" or $eMode == "w") {
            printf("<B>Device:</b><br>\n");
            printf("<TABLE>");
            printf("<TR><TD><B>ID</b></td> <TD><A HREF=https://meetjestad.net/data/sensors_recent.php?sensor=%s>%s</a></td></tr>", 
                    $aRowRslt['id'], $aRowRslt['id']); 
            printf("<TR><TD><B>type</b></td>     <TD>%s</td></tr>",    $aRowRslt['type']);
            printf("<TR><TD><B>sensor</b></td>   <TD>%s</td></tr>",    $aRowRslt['sensor']);
            printf("<TR><TD><B>location</b></td> <TD>%s</td></tr>",    $sSoilSoil);
            printf("<TR><TD><B>depths</b></td>   <TD>%s cm</td></tr>", $sSoilDepths);
            printf("</table><br>\n"); 
        }

        $laststart = 0;
	$lastname = "workshop";
	$calname = "default";
        if ($aRowRslt['calibrations']['workshop']['start'] === "") {   # empty calibration, use the default
            $laststart = $aRowDflt['calibrations'][$lastname]['start'];
            #$aRowRslt['calibrations'] = $aRowDflt['calibrations'];
	    $aRowRslt = $aRowDflt;
            if ($lDeb > 0) printf("74 Calibration \"%s\" conducted \"%s\".<br>\n", $calname, $laststart);
        } else {
            foreach ($aRowRslt['calibrations'] as $name=>$calibration) {
                # code is for now irrelevant since there is only 1 "workshop" with a "start"
                $start = (int) $calibration['start'];    # select the most recent calibration
                if ($laststart < $start)  {
			$laststart = $start;
			$calname = $name;
                }
                if ($lDeb > 1) printf("83 name=\"%s\" start=\"%s\"\n", $name, $start);
	    }
            if ($lDeb > 0) printf("85 Last calibration \"%s\" conducted \"%s\".<br>\n", $calname, $laststart);
	}
        
        $fSoilM1a =     (float) $aRowRslt['calibrations'][$lastname]['values']['soilM1']['a'];
        $fSoilM1b =     (float) $aRowRslt['calibrations'][$lastname]['values']['soilM1']['b'];
        $fSoilM1alpha = (float) $aRowRslt['calibrations'][$lastname]['values']['soilM1']['alpha'];
        $fSoilM1beta =  (float) $aRowRslt['calibrations'][$lastname]['values']['soilM1']['beta'];
        $fSoilM1gamma = (float) $aRowRslt['calibrations'][$lastname]['values']['soilM1']['gamma'];
        $fSoilT1a =     (float) $aRowRslt['calibrations'][$lastname]['values']['soilT1']['a'];
        $fSoilT1b =     (float) $aRowRslt['calibrations'][$lastname]['values']['soilT1']['b'];
        $fSoilM2a =     (float) $aRowRslt['calibrations'][$lastname]['values']['soilM2']['a'];
        $fSoilM2b =     (float) $aRowRslt['calibrations'][$lastname]['values']['soilM2']['b'];
        $fSoilM2alpha = (float) $aRowRslt['calibrations'][$lastname]['values']['soilM2']['alpha'];
        $fSoilM2beta =  (float) $aRowRslt['calibrations'][$lastname]['values']['soilM2']['beta'];
        $fSoilM2gamma = (float) $aRowRslt['calibrations'][$lastname]['values']['soilM2']['gamma'];
        $fSoilT2a =     (float) $aRowRslt['calibrations'][$lastname]['values']['soilT2']['a'];
        $fSoilT2b =     (float) $aRowRslt['calibrations'][$lastname]['values']['soilT2']['b'];

        if ($eMode == "h" or $eMode == "w") {
            printf("<br><A HREF=cal_bodem.json><B>Calibration</b></a> named \"%s\" dd %s:\n", $calname, $laststart);
            printf("<TABLE BORDER=0>\n");
            printf("<TR> <TH>&nbsp;</th> <TH>field</th>   <TH>function</th>\n");
            printf("<TH>multiplier</th>  <TH>offset</th> </tr>\n");
            printf("<TR> <TD>&nbsp;</td> <TD>extra%d</td> <TD>soilM1</td>\n",             $iSoilM1);
            printf("<TD>a=%.3f</td>      <TD>b=%.3f</td>\n",                              $fSoilM1a, $fSoilM1b );
            printf("<TD>&alpha;=%s</td>  <TD>&beta;=%s</td> <TD>&gamma;=%s</td> </tr>\n", $fSoilM1alpha, $fSoilM1beta, $fSoilM1gamma );
            printf("<TR> <TD>&nbsp;</td> <TD>extra%d</td> <TD>soilT1</td>\n",             $iSoilT1);
            printf("<TD>a=%.3f</td>      <TD>b=%.3f</td> </tr>\n",                        $fSoilT1a, $fSoilT1b );
            printf("<TR> <TD>&nbsp;</td> <TD>extra%d</td> <TD>soilM2</td>\n",             $iSoilM2);
            printf("<TD>a=%.3f</td>      <TD>b=%.3f</td>\n",                              $fSoilM2a, $fSoilM2b );
            printf("<TD>&alpha;=%s</td>  <TD>&beta;=%s</td> <TD>&gamma;=%s</td> </tr>\n", $fSoilM2alpha, $fSoilM2beta, $fSoilM2gamma );
            printf("<TR> <TD>&nbsp;</td> <TD>extra%d</td> <TD>soilT2</td>\n",             $iSoilT2);
            printf("<TD>a=%.3f</td>      <TD>b=%.3f</td> </tr>\n",                        $fSoilT2a, $fSoilT2b );
            printf("</table><br>\n");
        }
    }

    $aRetVal = array('soilM1'=>$iSoilM1,           'soilM1a'=>$fSoilM1a,       'soilM1b'=>$fSoilM1b, 
                     'soilM1alpha'=>$fSoilM1alpha, 'soilM1beta'=>$fSoilM1beta, 'soilM1gamma'=>$fSoilM1gamma, 
                     'soilT1'=>$iSoilT1,           'soilT1a'=>$fSoilT1a,       'soilT1b'=>$fSoilT1b, 
                     'soilM2'=>$iSoilM2,           'soilM2a'=>$fSoilM2a,       'soilM2b'=>$fSoilM2b, 
                     'soilM2alpha'=>$fSoilM2alpha, 'soilM2beta'=>$fSoilM2beta, 'soilM2gamma'=>$fSoilM2gamma, 
                     'soilT2'=>$iSoilT2,           'soilT2a'=>$fSoilT2a,       'soilT2b'=>$fSoilT2b); 
    if ($lDeb > 0) {
        printf("return:\n");
        print_r($aRetVal);
        printf("\n");
    }
    return $aRetVal;
}

?>
