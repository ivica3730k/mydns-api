<?php

function connectToDatabase(){
    require_once(__DIR__ . "/../credidentials/credidentials.php");
    $host = dbHostName();
    $username = dbUserName();
    $password = dbPassword();
    $db = dbBase();

    $conn = new mysqli($host, $username, $password, $db);
    // Check connection
    if ($conn->connect_errno) {
        exit();
    } else {
    }
    return $conn;
}

function closeDatabase($con)
{
    $con->close();
}

