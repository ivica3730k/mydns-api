<?php

require "dbconnection.php";

function addSoa($_apikey, $_zone, $_optimiseForDdns)
{
    $conn = connectToDatabase();
    if ($conn->connect_errno) echo "Unable to access database";
    $apikey = $conn->real_escape_string($_apikey);
    $zone = $conn->real_escape_string($_zone);
    $optimiseForDdns = $conn->real_escape_string($_optimiseForDdns);
    $sql = "CALL addSoa('$apikey','$zone','$optimiseForDdns')";
    $result = $conn->query($sql);
    closeDatabase($conn);
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        return $row["response"];
    }
}
