<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\StoryController;
use Illuminate\Support\Facades\Route;


Route::post('/register', [AuthController::class, 'register']);

Route::post('/login', [AuthController::class, 'login']); // endpoint para obtener token

Route::middleware('auth:sanctum')->group(function () {
    Route::prefix('story')->group(function () {
        Route::get('/list', [StoryController::class, 'index']);
        Route::post('/store', [StoryController::class, 'store']);
        Route::get('/show', [StoryController::class, 'show']);
        Route::put('/update', [StoryController::class, 'update']);
        Route::delete('/destroy', [StoryController::class, 'destroy']);
    });

    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me', [AuthController::class, 'me']);
});