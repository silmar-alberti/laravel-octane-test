<?php

use App\Http\Controllers\GetListController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/list', GetListController::class);

