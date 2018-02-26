<?php
	//script used for debugging purposes
	include 'ChromePhp.php';	
	
	$DB = $_POST['DB'];
	//connect to the mysql database
	$con = mysqli_connect("localhost", "iadapt", "Eife7Oorai", $DB, 3360, "/home/mysql/mysql.sock") or 
		ChromePhp::log("I cannot connect to mysql!");
	
	//turn of commit, so that all commands will be sent together. This ensures that we retrieve
	//the userID that is associated with the user information.	
	mysqli_autocommit($con,FALSE);
		
	//read in user info
	$data = $_POST['subjInfo'];
	
	// In Php, parameters are called KEYS (e.g. responseGiven)
	$keys = array_keys($data);
	$numKeys = sizeof($keys);
	
		
	// store user info as strings
	for ($i = 0; $i < $numKeys; $i++) {
		$subj_elements[$i] = "'".strval($data[$keys[$i]])."'";  
	}
	
	//concatenate column and value elements into strings
	$columns = implode(", ", $keys); 
	$values = implode(", ", $subj_elements);
	
	//write to table
	mysqli_query($con, "INSERT INTO Users ($columns) VALUES ($values)");
	//read ID from the last query
	$id = mysqli_insert_id($con);
	
	// Set initial time stamp. Setting the field to null updates the timestamp if a null value is not allowed
	mysqli_query($con,"UPDATE `USERS` SET USERS.`initialTimeStamp` = NULL WHERE USERS.id = $id");
	//commit all information together
	mysqli_commit($con);
	//close database connection
	mysqli_close($con);
	
	echo $id;

?>
