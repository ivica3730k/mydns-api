<?php

ini_set('display_startup_errors', 1);
ini_set('display_errors', 1);
error_reporting(-1);

$request = strtok($_SERVER['REQUEST_URI'], '?');
switch ($request) {
    case '':
    case '/' :
        require __DIR__ . '/views/index.php';
        break;
    case '/zone/add' :
        require __DIR__ . '/views/addSoa.php';
        break;
    case '/record/update' :
        require __DIR__ . '/views/updateRr.php';
        break;
    default:
        http_response_code(404);
        require __DIR__ . '/views/404.php';
        break;
}

