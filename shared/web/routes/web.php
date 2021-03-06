<?php

/** @var \Laravel\Lumen\Routing\Router $router */
/*
  |--------------------------------------------------------------------------
  | Application Routes
  |--------------------------------------------------------------------------
  |
  | Here is where you can register all of the routes for an application.
  | It is a breeze. Simply tell Lumen the URIs it should respond to
  | and give it the Closure to call when that URI is requested.
  |
 */

$router->get('/', function () use ($router) {
    return redirect('config');
});

/**
 * Application Routes
 */
$router->get('wizard', 'WizardController@index');
$router->post('getdirectorylisting', 'WizardController@getDirectoryListing');
$router->post('validateemail', 'WizardController@validateemail');
$router->post('validatewalletaddress', 'WizardController@validateWalletAddress');
$router->post('validatestoragedirectorypath', 'WizardController@validateStorageDirectoryPath');
$router->post('validatehost', 'WizardController@validateHost');
$router->post('getidentity', 'IdentityController@index');
$router->post('saveconfig', 'WizardController@saveConfig');
$router->post('updatehostaddress', 'ConfigController@updateHostAddress');
$router->post('updatewalletaddress', 'ConfigController@updateWalletAddress');
$router->post('updatestorageallocate', 'ConfigController@updateStorageAllocate');
$router->post('updatestoragedirectory', 'ConfigController@updateStorageDirectory');
$router->post('updateemailaddress', 'ConfigController@updateEmailAddress');
$router->get('config', 'ConfigController@index');
$router->post('config', 'ConfigController@config');
$router->post('checkRunningnode', 'ConfigController@checkRunningnode');
$router->post('isstartajax', 'ConfigController@isstartajax');
$router->post('stopNode', 'ConfigController@stopNode');
$router->post('startNode', 'ConfigController@startNode');
$router->post('updateNode', 'ConfigController@updateNode');
$router->post('setauthswitch', 'ConfigController@setAuthswitch');
$router->get('login', 'LoginController@index');
$router->post('authenticate', 'LoginController@authenticate');
