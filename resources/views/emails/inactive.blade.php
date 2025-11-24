@component('mail::message')
# ¡Te echamos de menos, {{ $user->name }}!

Hace más de **una semana** que no escribes una historia nueva.

Agatha está lista cuando tú quieras continuar ✍️💙

@component('mail::button', ['url' => config('app.url').'/home'])
Volver a escribir
@endcomponent

Gracias por seguir aquí,<br>
**El equipo de Agatha**
@endcomponent
