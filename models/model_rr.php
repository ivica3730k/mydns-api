<?php

require "dbconnection.php";

function addRr($apikey,$zone,$record,$type,$data) {
    $conn = connectToDatabase();
    $_apikey = $conn->real_escape_string($apikey);
    $_zone = $conn->real_escape_string($zone);
    $_record = $conn->real_escape_string($record);
    $_type = $conn->real_escape_string($type);
    $_data = $conn->real_escape_string($data);
    $sql = "CALL addRr('$_apikey','$_zone','$_record','$_type','$_data')";
    $result = $conn->query($sql);
    closeDatabase($conn);
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        return $row["response"];
    }
}

function updateRr($apikey, $record, $newData)
{
    $conn = connectToDatabase();
    if ($conn->connect_errno) echo "Unable to access database";
    $_apikey = $conn->real_escape_string($apikey);
    $_record = $conn->real_escape_string($record);
    $_newData = $conn->real_escape_string($newData);
    $sql = "CALL updateRr('$_apikey','$_record','$_newData')";
    $result = $conn->query($sql);
    closeDatabase($conn);
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        return $row["response"];
    }
}

