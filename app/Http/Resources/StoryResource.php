<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class StoryResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'Token'     => $this->story_token,
            'Word'      => $this->random_word,
            'Place'     => $this->random_place,
            'Title'     => $this->title,
            'Content'   => $this->content,
            'Words'     => $this->word_count,
            'UserId'    => $this->user_id,
        ];
    }
}
