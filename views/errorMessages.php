<?php
function invalidUser (){
    http_response_code(401);
    echo "Your api key is not registered on the system.\n
    Make sure that you have enter your api key correcty.\n";
    echo "Error message : ";

}

function existingZone() {
    http_response_code(409);
    echo "The domain that you are trying to add is already
    present on the system. Make sure you domain is unique.\n";
    echo "Error message : ";
}

function notRecordOwner() {
    http_response_code(401);
    echo "Record that you are trying to update is not in your ownership\n";
    echo "Error message : ";

}

function noRecord() {
    http_response_code(412);
    echo "Record that you are trying to update does not exist on the system\n";
    echo "Error message : ";

}