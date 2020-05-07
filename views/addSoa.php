<?php


require_once(__DIR__ . "/../models/model_soa.php");
require_once(__DIR__ . "/../helpers/stringHelpers.php");
require_once("errorMessages.php");
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $apikey = $_POST["apikey"];
    $zone = $_POST["zone"];
    $zone = validateDomainName($zone);
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
        invalidRequestMissingParameters("apikey,zone ,and optional: ddns");
    }

    $result = addSoa($apikey, $zone, $optimiseForDdns);

    if ($result != "OK") {
        if ($result == "INVUSER") {
            invalidUser();
        } else if ($result == "EXISTINGSOA") {
            existingZone();
        } else {
            #For error messages that database might throw in future
            #that are currently not implemented
        }
    }
    echo $result;

} else {
    echo "GET request not implemented yet";
}
