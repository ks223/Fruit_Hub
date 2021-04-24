<?php
$servername = "localhost";
$username   = "id16671479_fruithubadmin";
$password   = "irf1>?w^AXk77423";
$dbname     = "id16671479_fruithubdb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>