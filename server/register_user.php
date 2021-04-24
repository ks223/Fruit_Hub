<?php

include_once("dbconnect.php");

$name = $_POST['name'];
$user_email = $_POST['email'];
$password = $_POST['password'];
$passha1 = sha1($password);
$otp = rand(1000,9999);

$sqlregister = "INSERT INTO tbl_user(name,user_email,password,otp) VALUES('$name','$user_email','$passha1','$otp')";
if ($conn->query($sqlregister) === TRUE){
    echo "success";
}else{
    echo "failed";
}


?>