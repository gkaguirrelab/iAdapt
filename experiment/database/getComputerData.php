<?php

$DB = $_POST['DB'];
//open connection to mysql server. Enter server name, username, password, and database
$con = mysqli_connect("localhost", "iadapt", "Eife7Oorai", $DB, 3360, "/home/mysql/mysql.sock") or 
		ChromePhp::log("I cannot connect to mysql!");


$id = $_POST['userID'];
$userAgent = $_SERVER['HTTP_USER_AGENT'];
$ipAddress = $_SERVER['REMOTE_ADDR'];

// Store IP address and userAgent
mysqli_query($con, "UPDATE `Users` SET Users.`userAgent` = '$userAgent' WHERE Users.`ID` = $id");
mysqli_query($con, "UPDATE `Users` SET Users.`ipAddress` = '$ipAddress' WHERE Users.`ID` = $id");


?>