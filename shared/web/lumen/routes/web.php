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
    return $router->app->version();
});

/**
 * Wizard page
 */
$router->get('wizard', 'WizardController@index');
$router->post('getdirectorylisting', 'WizardController@getDirectoryListing');
$router->post('getidentity', 'IdentityController@index');
$router->post('saveconfig', 'WizardController@saveConfig');
$router->get('config', 'ConfigController@index');
$router->post('config', 'ConfigController@config');
