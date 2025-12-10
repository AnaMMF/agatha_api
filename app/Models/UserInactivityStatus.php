<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserInactivityStatus extends Model
{
    protected $table = 'user_inactivity_status';
    
    protected $fillable = [
        'user_id',
        'first_email_sent_at',
        'second_email_sent_at',
        'last_story_at',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
