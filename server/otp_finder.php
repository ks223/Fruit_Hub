<?php

include_once("dbconnect.php");
 $email = $_GET['email'];
$sql = "SELECT otp FROM tbl_user WHERE user_email = '$email'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
  $row = $result->fetch_assoc();
  echo $row['otp'];
  
}