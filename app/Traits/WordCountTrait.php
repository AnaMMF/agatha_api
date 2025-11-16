<?php

namespace App\Traits;

trait WordCountTrait
{
    /**
     * Count words in a text
     * @param string $text
     * @return int
     */
    public function countWords(string $text): int
    {
        $cleanText = trim(strip_tags($text)); // elimina HTML
        $cleanText = preg_replace('/\s+/', ' ', $cleanText); // normaliza espacios

        return str_word_count($cleanText);
    }
}
