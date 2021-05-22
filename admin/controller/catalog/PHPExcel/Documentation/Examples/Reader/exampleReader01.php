<?php

error_reporting(E_ALL);
set_time_limit(0);

date_default_timezone_set('Europe/London');

/** Include path **/
set_include_path(get_include_path() . PATH_SEPARATOR . '../../../Classes/');

/** PHPExcel_IOFactory */
include 'PHPExcel/IOFactory.php';

//$inputFileName = './sampleData/jxlrwtest.xls';
$inputFileName = $_SERVER["DOCUMENT_ROOT"].'/admin/controller/accounting/PHPExcel/Documentation/Examples/Reader/sampleData/jxlrwtest.xls';
$objPHPExcel = PHPExcel_IOFactory::load($inputFileName);
$header = array();
$data = array();
$sheetData = $objPHPExcel->getActiveSheet()->toArray(null,true,true,true);
// To add more columns to the sheet only change the end parameter
// of  for  from 'H' to the letter of the last new column
foreach($sheetData as  $key => $row){
	if($key==1){
		for($i = 'A'; $i <= 'H'; $i++){
			// Excel Header Row Containing Column Names
			$header[$i]=$row[$i]; 
		}	
	}
	else if($key == sizeof($sheetData)){
		//total is written in column 'H' of the last row
		$total=$row['G'];	
	}
	else {
		for($i = 'A'; $i <= 'H'; $i++){
           echo '1';
		} 
	}
	echo('  ');
} 
echo (var_dump($header));
echo '<br>';
?>
<body>
</html>