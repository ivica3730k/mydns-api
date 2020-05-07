<?php
function validateApiKey($apikey) {
    if (strlen($apikey) > 64) {
        return false;
    }
}