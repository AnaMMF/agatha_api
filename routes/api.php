

<?php

use App\Http\Controllers\StoryController;
use Illuminate\Support\Facades\Route;


Route::group(['prefix' => 'story'], function () {
            Route::get('/list', [StoryController::class, 'index']);
            Route::post('/store', [StoryController::class, 'store']);
            Route::get('/show/{competitorToken}', [StoryController::class, 'show']);
            Route::put('/update/{competitorToken}', [StoryController::class, 'update']);
            Route::delete('/destroy/{competitorToken}', [StoryController::class, 'destroy']);
        });
