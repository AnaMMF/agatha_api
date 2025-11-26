<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;
use App\Mail\InactiveUserMail;
use Illuminate\Support\Facades\Mail;
use Carbon\Carbon;

class CheckInactiveUsers extends Command
{
    protected $signature = 'users:check-inactive';
    protected $description = 'Send email to users who have not written in 7 days';

    public function handle()
    {
        $sevenDaysAgo = Carbon::now()->subDays(7);

        // usuarios que no han escrito en 7 días
        //TODO: evitar enviar más de un mail por semana
        $users = User::whereDoesntHave('stories', function ($check) use ($sevenDaysAgo) {
            $check->where('created_at', '>=', $sevenDaysAgo);
        })->get();

        foreach ($users as $user) {
                        sleep(2); //Mailtrap solo permite un email por segundo

            Mail::to($user->email)->send(new InactiveUserMail($user));
            $this->info("Mail enviado a: " . $user->email);

            sleep(2); //Mailtrap solo permite un email por segundo
        }

        return Command::SUCCESS;
    }
}
