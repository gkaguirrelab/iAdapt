<?php

$DB = $_POST['DB'];
//open connection to mysql server. Enter server name, username, password, and database
$con = mysqli_connect("localhost", "iadapt", "Eife7Oorai", $DB, 3360, "/home/mysql/mysql.sock") or 
		ChromePhp::log("I cannot connect to mysql!");


//Produce a psuedo-random number from 1,000,000,000 to 9,999,999,999 used as a code for mechanical turk
$code = mt_rand(1000000000, 9999999999);

//Check to see if the code was already used. Continue generating new code until a unique one is reached
$result = mysqli_query($con, "SELECT `completionCode` FROM `Users` WHERE Users.`completionCode` = $code");
while (mysqli_num_rows($result) > 0) {
    $code   = mt_rand(1000000000, 9999999999);
    $result = mysqli_query($con, "SELECT `completionCode` FROM `Users` WHERE Users.`completionCode` = $code");
}

$id = $_POST["userID"];

//Insert completion code into users table 
mysqli_query($con, "UPDATE `Users` SET Users.`completionCode` = $code WHERE Users.ID = $id");
// Set final time stamp. Setting the field to null updates the timestamp if a null value is not allowed
mysqli_query($con,"UPDATE `Users` SET Users.`finalTimeStamp` = NULL WHERE Users.ID = $id");
echo $code;

?>