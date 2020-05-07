<?php
function stringEndsWith($string, $test) {
    $strlen = strlen($string);
    $testlen = strlen($test);
    if ($testlen > $strlen) return false;
    return substr_compare($string, $test, $strlen - $testlen, $testlen) === 0;
}

function validateDomainName ($domainname) {
    if (!stringEndsWith($domainname,".")){
        $domainname .= ".";
    }
    return $domainname;
}