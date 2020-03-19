<?php

function connectToDatabase(){
    $host = "docker.ivica.codes";
    $username = "dnsadmin";
    $password = "dnsadmin";
    $db = "mydns";
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

