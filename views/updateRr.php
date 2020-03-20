<?php

function getRealIpAddr()
{
    if (!empty($_SERVER['HTTP_CLIENT_IP']))   //check ip from share internet
    {
        $ip = $_SERVER['HTTP_CLIENT_IP'];
    } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))   //to check ip is pass from proxy
    {
        $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
    } else {
        $ip = $_SERVER['REMOTE_ADDR'];
    }
    return $ip;
}

require_once(__DIR__ . "/../models/model_rr.php");
require_once("errorMessages.php");

if ($_SERVER["REQUEST_METHOD"] === 'GET') {
    $apikey = $_GET["apikey"];
    $record = $_GET["record"];
    if (!isset($apikey) or !isset($record)) {
        http_response_code(400);
        echo "Request is not valid, make sure that you have following : apikey,record";
        exit(0);
    }
    $result = updateRr($apikey, $record, getRealIpAddr());
    if ($result != "OK") {
        if ($result == "NOTOWNER") {
            notRecordOwner();
        } else if ($result == "INVUSER") {
            invalidUser();
        } else if ($result == "NORECORD") {
            noRecord();
        } else {
            #For error messages that database might throw in future
            #that are currently not implemented
        }
    }
    echo $result;
}
?>