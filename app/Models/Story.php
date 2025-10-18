<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Story extends Model
{
    protected $table = 'stories';

    protected $fillable = [
        "story_token",
        "random_word",
        "random_place",
        "title",
        "content",
        "word_count",
        "user_id",
    ];

    protected $hidden = [
        'id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

}
