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


$data = array();
$doc = new DOMDocument();
$doc->loadHTML($sRuwBestand);
$rows = $doc->getElementsByTagName('tr');
print_r ($rows);

foreach($rows as $row) {
    $values = array();
    foreach($row->childNodes as $cell) {
        printf("%s, ", $cell->textContent);
        $values[] = $cell->textContent;
    }
    $data[] = $values;
    printf("\n");
}

print_r ($data);

fclose($fRuwBestand);
fclose($fErrBestand);

?>
