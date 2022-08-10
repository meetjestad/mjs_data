<?php


function print_calibration($sNode, $eMode = "") {
    $iDeb = 0;
    if ($iDeb > 0) printf("print_calibration: Node=%s Mode=%s\n", $sNode, $eMode);

    if (file_exists('cal_greenroof.json'))    $sJson = file_get_contents("cal_greenroof.json");      # running from index directory
    if (file_exists('../cal_greenroof.json')) $sJson = file_get_contents("../cal_greenroof.json");   # running from php directory
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
                printf("<A HREF=cal_greenroof.json>json</a> error: node %s not found and default not found: no calibration<br>\n", $sNode);
                return array(false, false, false, false, false, false);
            }
        }
    }
    if ($iDeb > 1) {
        printf("RowRslt=\n");
        print_r($aRowRslt);
        printf("\n");
    }

    $s='&nbsp;';
    if ($aRowRslt !== false) {
        $iSoilM = (int) $aRowRslt['format']['soilM'];
        $iSoilT = (int) $aRowRslt['format']['soilT'];
        $fSoilMa = (float) $aRowRslt['calibration']['soilM']['a'];
        $fSoilMb = (float) $aRowRslt['calibration']['soilM']['b'];
        $fSoilTa = (float) $aRowRslt['calibration']['soilT']['a'];
        $fSoilTb = (float) $aRowRslt['calibration']['soilT']['b'];
        if ($eMode == "h") {
	    printf("<B>Device</b><br>\n");
	    printf("<TABLE>\n");
	    printf("<TR><TD>&nbsp;</td><TD>ID</td><TD>%s</td></tr>\n", $aRowRslt['id']);
	    printf("<TR><TD>&nbsp;</td><TD>type</td><TD>%s</td></tr>\n", $aRowRslt['type']);
	    printf("<TR><TD>&nbsp;</td><TD>sensor</td><TD>%s</td></tr>\n", $aRowRslt['sensor']);
	    printf("</table>\n");
	    printf("<B>Fields</b><br>\n");
	    printf("<TABLE>\n");
	    printf("<TR><TD>&nbsp;</td><TD>extra%d</td><TD>soilM</td></tr>\n", $iSoilM);
	    printf("<TR><TD>&nbsp;</td><TD>extra%d</td><TD>soilT</td></tr>\n", $iSoilT);
	    printf("</table>\n");
	    printf("<B>Calibration soilM</b><br>\n");
	    printf("<TABLE>\n");
	    printf("<TR><TD>&nbsp;</td><TD>a</td><TD>%.3f</td></tr>\n", $fSoilMa);
	    printf("<TR><TD>&nbsp;</td><TD>b</td><TD>%.3f</td></tr>\n", $fSoilMb);
	    printf("</table>\n");
	    printf("<B>Calibration soilT</b><br>\n");
	    printf("<TABLE>\n");
	    printf("<TR><TD>&nbsp;</td><TD>a</td><TD>%.3f</td></tr>\n", $fSoilTa);
	    printf("<TR><TD>&nbsp;</td><TD>b</td><TD>%.3f</td></tr>\n", $fSoilTb);
	    printf("</table>\n");
        }
    }

    $aRetVal = array('soilM'=>$iSoilM, 'soilT'=>$iSoilT, 'soilMa'=>$fSoilMa, 'soilMb'=>$fSoilMb, 'soilTa'=>$fSoilTa, 'soilTb'=>$fSoilTb);
    if ($iDeb > 0) {
        printf("return:\n");
        print_r($aRetVal);
        printf("\n");
    }
    return $aRetVal;
}
?>
