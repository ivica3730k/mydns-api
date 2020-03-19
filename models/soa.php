<?php
require "dbconnection.php";

function addSoa($_apikey, $_origin, $_optimiseForDdns)
{
    $conn = connectToDatabase();
    if ($conn->connect_errno) echo "Unable to access database";
    $apikey = $conn->real_escape_string($_apikey);
    $origin = $conn->real_escape_string($_origin);
    $optimiseForDdns = $conn->real_escape_string($_optimiseForDdns);
    $sql = "CALL addSoa('$apikey','$origin','$optimiseForDdns')";
    $result = $conn->query($sql);
    closeDatabase($conn);
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        return $row["response"];
    }
}