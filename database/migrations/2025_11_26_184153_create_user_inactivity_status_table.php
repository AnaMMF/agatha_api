<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
{
    Schema::create('user_inactivity_status', function (Blueprint $table) {
        $table->id();
        $table->foreignId('user_id')->constrained()->onDelete('cascade');

        // fecha del primer aviso enviado
        $table->timestamp('first_email_sent_at')->nullable();

        // fecha del segundo aviso enviado
        $table->timestamp('second_email_sent_at')->nullable();

        // fecha de la última actividad registrada (guardar una copia)
        $table->timestamp('last_story_at')->nullable();

        $table->timestamps();
    });
}


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_inactivity_status');
    }
};
