<?php


require_once(__DIR__ . "/../models/model_soa.php");
require_once("errorMessages.php");
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $apikey = $_POST["apikey"];
    $zone = $_POST["zone"];
    $optimiseForDdns = $_POST["ddns"];
    if (isset($optimiseForDdns)) {
        if ($optimiseForDdns . strtolower($optimiseForDdns) == "true" or $optimiseForDdns == "1") {
            $optimiseForDdns = "1";
        } else {
            $optimiseForDdns = "0";
        }
    } else {
        $optimiseForDdns = "0";
    }

    if (!isset($apikey) or !isset($zone)) {
        http_response_code(400);
        echo "Request is not valid, check that you have following : apikey,zone,ddns";
    }

    $result = addSoa($apikey, $zone, $optimiseForDdns);

    if ($result != "OK") {
        if ($result == "INVUSER") {
            invalidUser();
        }
        else if ($result == "EXISTINGSOA"){
            existingZone();
        }
        else {
            http_response_code(400);
        }
    }
    echo $result;

} else {
    echo "GET request not implemented yet";
}
