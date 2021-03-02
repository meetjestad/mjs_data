<?php

error_reporting(E_ALL);   // PHP

date_default_timezone_set('Europe/Amsterdam');


$sErrBestand = $argv[0] . ".err";
$fErrBestand = fopen($sErrBestand, 'w');
if (! $fErrBestand) {
   die("Onoverkomelijk: Kan $sErrBestand niet schrijven\n");
}
printf("ErrBestand=%s\n", $sErrBestand);

if ($argc < 2) {
    die("gebruik: $argv[0] bestand.ruw.\n");
}

$sRuwBestand = $argv[1];
$fRuwBestand = fopen($sRuwBestand, 'r');
if (! $fRuwBestand) {
         die("Onoverkomelijk: Kan $sRuwBestand niet lezen\n");
}
printf("RuwBestand=%s\n", $sRuwBestand);

$htmlContent = file_get_contents($sRuwBestand);
		
	$DOM = new DOMDocument();
	$DOM->loadHTML($htmlContent);
	
	$Header = $DOM->getElementsByTagName('th');
	$Detail = $DOM->getElementsByTagName('td');

    //#Get header name of the table
	foreach($Header as $NodeHeader) 
	{
		$aDataTableHeaderHTML[] = trim($NodeHeader->textContent);
	}
	//print_r($aDataTableHeaderHTML); die();

	//#Get row data/detail table without header name as key
	$i = 0;
	$j = 0;
	foreach($Detail as $sNodeDetail) 
	{
		$aDataTableDetailHTML[$j][] = trim($sNodeDetail->textContent);
		$i = $i + 1;
		$j = $i % count($aDataTableHeaderHTML) == 0 ? $j + 1 : $j;
	}
	print_r($aDataTableDetailHTML);
	
	//#Get row data/detail table with header name as key and outer array index as row number
	for($i = 0; $i < count($aDataTableDetailHTML); $i++)
	{
		for($j = 0; $j < count($aDataTableHeaderHTML); $j++)
		{
			$aTempData[$i][$aDataTableHeaderHTML[$j]] = $aDataTableDetailHTML[$i][$j];
		}
	}
	$aDataTableDetailHTML = $aTempData; unset($aTempData);
	print_r($aDataTableDetailHTML);


fclose($fRuwBestand);
fclose($fErrBestand);

?>
