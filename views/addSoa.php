<?php
require_once(__DIR__ . "/../models/soa.php");
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $apikey = $_POST["apikey"];
    $origin = $_POST["zone"];
    $optimiseForDdns = $_POST["ddns"];
    if (isset($optimiseForDdns)) {
        if ($optimiseForDdns . strtolower() == "true" or $optimiseForDdns == "1") {
            $optimiseForDdns = "1";
        } else {
            $optimiseForDdns = "0";
        }
    } else {
        $optimiseForDdns = "0";
    }

    if (isset($apikey) and isset($origin)) {
        echo addSoa($apikey, $origin, $optimiseForDdns);
    } else {
        echo "Request is not valid, check that you have following : apikey,zone,ddns";
    }
} else {
    echo "GET request not implemented yet";
}
