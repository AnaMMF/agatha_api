<?php

namespace App\Console\Commands;

use App\Mail\FirstInactiveUserMail;
use App\Mail\SecondInactiveUserMail;
use App\Models\User;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Mail;

class CheckInactiveUsers extends Command
{
    protected $signature = 'users:check-inactive';
    protected $description = 'Envía avisos por inactividad a los usuarios';

    public function handle()
    {
        $users = User::with(['stories', 'inactivity'])->get();

        foreach ($users as $user) {
            $lastStory = $user->stories()->latest()->first();

            if (!$lastStory) {
                continue;
            }

            $days = $lastStory->created_at->diffInDays(now());

            $this->info("Usuario {$user->email} → días: $days");

            // Crear registro si no existe
            $status = $user->inactivity ?: $user->inactivity()->create([
                'last_story_at' => $lastStory->created_at
            ]);

            // RESET al volver a escribir   
            if ($days < 1) {
                $status->update([
                    'first_email_sent_at' => null,
                    'second_email_sent_at' => null,
                    'last_story_at' => $lastStory->created_at
                ]);
                continue;
            }

            // 7 días → primer aviso (solo se envía una vez)
            if ($days >= 1 && $days < 5) {
                if (!$status->first_email_sent_at) {
                    try {
                        Mail::to($user->email)->send(new FirstInactiveUserMail($user));
                        $this->info("Primer aviso enviado a {$user->email}");
                        usleep(500000); // 0.5 segundos
                        $status->update(['first_email_sent_at' => now()]);
                    } catch (\Throwable $e) {
                        $this->error("Error enviando primer aviso a {$user->email}: " . $e->getMessage());
                        // opcional: logear
                        \Log::error("Error mail first to {$user->email}", ['exception' => $e]);
                    }
                }
                continue;
            }

            // 25 días → segundo aviso (solo una vez)
            if ($days >= 5) {
                if (!$status->second_email_sent_at) {
                    try {
                        Mail::to($user->email)->send(new SecondInactiveUserMail($user));
                        $this->info("Segundo aviso enviado a {$user->email}");
                        usleep(500000); // 0.5 segundos
                        $status->update(['second_email_sent_at' => now()]);
                    } catch (\Throwable $e) {
                        $this->error("Error enviando segundo aviso a {$user->email}: " . $e->getMessage());
                        \Log::error("Error mail second to {$user->email}", ['exception' => $e]);
                    }
                }
            }
        }

        return 0;
    }
}
