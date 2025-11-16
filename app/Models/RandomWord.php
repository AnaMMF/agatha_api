<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RandomWord extends Model
{
    protected $table = 'random_words';

    protected $fillable = [
        'type',
        'value',
    ];

    protected $hidden = [
        'id',
    ];
}
