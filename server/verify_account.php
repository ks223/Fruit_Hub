<?php
    error_reporting(0);
    include_once("dbconnect.php");
    $email = $_GET['email'];
    
    $sql = "SELECT * FROM tbl_user WHERE user_email = '$email' ";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $sqlupdate = "UPDATE tbl_user SET otp = '0' WHERE user_email = '$email'";
        if ($conn->query($sqlupdate) === TRUE){
            echo 'success';
        }else{
            echo 'failed';
        }   
    }else{
        echo "failed";
    }
    
    
?>
