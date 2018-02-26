<?php
	//script used for debugging purposes
	include 'ChromePhp.php';
	
	$DB = $_POST['DB'];
	//connect to the mysql database
	$con = mysqli_connect("localhost", "iadapt", "Eife7Oorai", $DB, 3360, "/home/mysql/mysql.sock") or 
		ChromePhp::log("I cannot connect to mysql!");
	
	//read in user variables
	$data = $_POST['expData'];
	$userID = $_POST['userID'];
	$dbTableName = $_POST['dbTableName'];
	
	// In Php, parameters are called KEYS (e.g. responseGiven)
	$keys = array_keys($data);
	$numKeys = sizeof($keys);
	
		
	// fill array with array end values
	for ($i = 0; $i < $numKeys; $i++) {
		$trial_elements[$i] = end($data[$keys[$i]]);
		// Check if trial element is a string of alphabetic characters that is not 'null'
		if(ctype_alpha ($trial_elements[$i]) && strcasecmp($trial_elements[$i], 'null')!= 0){
			$trial_elements[$i] = "'".$trial_elements[$i]."'";
		}else if(trim($trial_elements[$i]) == ""){
			$trial_elements[$i] = "NULL";
		}
	}
	
	// add userID info
	array_unshift($keys, "userID");
	array_unshift($trial_elements, $userID);
	print_r($trial_elements);
	
	// concatenate column and value elements into strings
	$columns = implode(", ", $keys); 
	$values = implode(", ", $trial_elements);
	
	//write to table
	$query = "INSERT INTO $dbTableName ($columns) VALUES ($values)";
	mysqli_query($con, $query);
	

	
	
	// To use print_r for debugging, you MUST return and print the variable to the console upon ajax success
	//	$element = end($data['responseGiven']);  //works!

?>