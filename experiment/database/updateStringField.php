<?php
	//script used for debugging purposes
	include 'ChromePhp.php';	

	$DB = $_POST['DB'];
	//connect to the mysql database
	$con = mysqli_connect("localhost", "iadapt", "Eife7Oorai", $DB, 3360, "/home/mysql/mysql.sock") or 
		ChromePhp::log("I cannot connect to mysql!");
		
	$id = $_POST['ID'];
	$table = $_POST['table'];
	$field = $_POST['field'];
	$value = $_POST['value'];
	// mysqli_query($con,"UPDATE `Users` SET Users.`userAgent` = 'Shmoo' WHERE $table.id = $id");
	mysqli_query($con,"UPDATE `$table` SET $table.`$field` = '$value'  WHERE $table.id = $id");
?>
