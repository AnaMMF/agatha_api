---
marp: true
theme: gaia
paginate: true
lang: es
size: 16:9                

title: "Implementación"
class: invert          
titlepage: true
titlepage-rule-color: "360049"
titlepage-rule-height: 6
---

# 4. Implementación

En este apartado se describen los componentes más relevantes del proyecto, tanto del **backend en Laravel** como del **frontend en Vue 3**, junto con ejemplos reales de código utilizados.

---

### 4.1. Autenticación con Laravel Sanctum

Agatha-api utiliza **Laravel Sanctum** para gestionar autenticación mediante tokens.

El flujo es el siguiente:

1. El usuario inicia sesión desde el frontend.  
2. El backend valida las credenciales.  
3. Si son correctas, genera un **token con duración de 12 horas**.  
4. El token se guarda en LocalStorage y se envía en cada petición con Axios.

---

#### Controlador AuthController

```php
public function login(Request $request)
{
    $data = $request->validate([
        'email' => 'required|email',
        'password' => 'required',
    ]);

    if (!Auth::attempt($data)) {
        return response()->json(['success' => false, 'message' => 'Incorrecto'], 401);
    }

    $user = $request->user();
    $token = $user->createToken('api-token', ['*'], now()->addHours(12))->plainTextToken;

    return response()->json([
        'success' => true,
        'token' => $token,
        'user' => $user,
    ]);
}
```

---

### 4.2. Registro y actualización de usuario

El registro exige contraseñas fuertes (mínimo 8 caracteres, mayúsculas, minúsculas, números y símbolos).

#### Validación de registro:
```php

$data = $request->validate([
    'name' => 'required|string|max:255',
    'email' => 'required|string|email|max:255|unique:users,email',
    'password' => [
        'required',
        'confirmed',
        Password::min(8)->letters()->mixedCase()->numbers()->symbols(),
    ],
]);
```
#### Actualización de usuario:
```php
$data = $request->validate([
    'name' => 'sometimes|string|max:255',
    'email' => 'sometimes|email|unique:users,email,' . $user->id,
    'password' => [
        'nullable',
        'confirmed',
        Password::min(8)->letters()->mixedCase()->numbers()->symbols(),
    ],
]);

```
---

### 4.3. Frontend de Autenticación (Vue 3 + Pinia)

El frontend almacena el token en LocalStorage y lo añade automáticamente con un interceptor Axios.

#### Interceptor en api.js

```php
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token')
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
  return config
})
```

#### Ejemplo real: vista LoginView.vue
```php

async function handleLogin() {
  const data = await login(email.value, password.value)

  if (!data.success) {
    message.value = 'Credenciales incorrectas'
    return
  }

  authStore.setUser(data.user)
  authStore.setToken(data.token)
  router.push('/home')
}
```

---

### 4.4. Rutas API

```php

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::prefix('story')->group(function () {
        Route::get('/list', [StoryController::class, 'index']);
        Route::post('/store', [StoryController::class, 'store']);
        Route::get('/show', [StoryController::class, 'show']);
        Route::put('/update', [StoryController::class, 'update']);
        Route::delete('/destroy', [StoryController::class, 'destroy']);
        Route::get('/random', [StoryController::class, 'randomWords']);
    });

    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me', [AuthController::class, 'me']);
    Route::put('/user', [AuthController::class, 'update']);
});
```
---

### 4.5. Generación de palabra y lugar aleatorios

Agatha usa una única tabla random_words, con dos tipos:

word → palabras

place → lugares

```php
$word = RandomWord::where('type', 'word')->inRandomOrder()->value('value');
$place = RandomWord::where('type', 'place')->inRandomOrder()->value('value');
```

---


### 4.6. Validación de historias

Se exige que la historia incluya la palabra y el lugar proporcionados:

```php
if (
    stripos($request->content, $word) === false ||
    stripos($request->content, $place) === false
) {
    return response()->json([
        "success" => false,
        "message" => "La historia debe incluir la palabra '{$word}' y el lugar '{$place}'."
    ], 422);
}
```
---

### 4.7. Guardado de historias con token único

```php
$story = Story::create([
    'story_token' => Str::uuid()->toString(),
    'random_word' => $request->word,
    'random_place' => $request->place,
    'title' => $request->title,
    'content' => $request->content,
    'word_count' => $this->countWords($request->content),
    'user_id' => $request->user_id,
]);
```
---

### 4.8. Reset de inactividad al escribir
```php
$status = $story->user->inactivity;

if ($status) {
    $status->update([
        'last_story_at' => now(),
        'first_email_sent_at' => null,
        'second_email_sent_at' => null,
    ]);
} else {
    $story->user->inactivity()->create([
        'last_story_at' => now(),
    ]);
}

```
---

### 4.9. Frontend de historias (Vue)
#### Obtener historias
```php
export async function getStories() {
  const { data } = await api.get('/story/list')
  return data
}
```

#### Crear historia
```php
export async function createStory(story) {
  return api.post('/story/store', {
    title: story.title,
    word: story.word,
    place: story.place,
    content: story.content,
    user_id: story.user_id,
  })
}
```
---

### 4.10. Formateo de fechas (frontend)
```php
function formatDate(dateString) {
  return new Date(dateString).toLocaleDateString('es-ES', {
    year: 'numeric',
    month: 'numeric',
    day: 'numeric'
  })
}
```
---
### 4.11. Sistema de avisos automáticos por inactividad

El comando users:check-inactive recorre todos los usuarios y:

- Calcula días sin escribir.
- Envía primer aviso.
- Envía segundo aviso.
- Registra fechas en la tabla inactivities.

Código real del comando:
```php

$lastStory = $user->stories()->latest()->first();
$days = $lastStory->created_at->diffInDays(now());

$status = $user->inactivity ?: $user->inactivity()->create([
    'last_story_at' => $lastStory->created_at
]);
```
Primer aviso:
```php

if ($days >= 1 && $days < 5) {
    if (!$status->first_email_sent_at) {
        Mail::to($user->email)->send(new FirstInactiveUserMail($user));
        $status->update(['first_email_sent_at' => now()]);
    }
}
```
Segundo aviso:
```php
if ($days >= 5) {
    if (!$status->second_email_sent_at) {
        Mail::to($user->email)->send(new SecondInactiveUserMail($user));
        $status->update(['second_email_sent_at' => now()]);
    }
}

```
---

### 4.12. Mailable real
```php
class FirstInactiveUserMail extends Mailable
{
    use Queueable, SerializesModels;

    public function __construct(public $user) {}

    public function content(): Content
    {
        return new Content(
            markdown: 'emails.inactive_first',
            with: ['user' => $this->user]
        );
    }
}
```
---

### 4.13. Plantilla Markdown del email
```php
@component('mail::message')
# ¡Te echamos de menos, {{ $user->name }}!

Hace más de una semana que no escribes una historia.

@component('mail::button', ['url' => config('app.url').'/home'])
Volver a escribir
@endcomponent

Gracias,<br>
El equipo de Agatha
@endcomponent
```
---

### 4.14. Estructura de carpetas del backend (Laravel)
├───app
│   ├───Actions
│   │   └───Fortify
│   ├───Console
│   │   └───Commands
│   ├───Http
│   │   ├───Controllers
│   │   │   ├───Controller.php
│   │   │   ├───StoryController.php
│   │   │   └───Api
│   │   │       ├───Controller.php
│   │   │       └───StoryController.php
│   │   └───Resources
│   ├───Mail
│   │   ├───FirstInactiveUserMail.php
│   │   │   InactiveUserMail.php
│   │   └───SecondInactiveUserMail.php
│   ├───Models
│   │   ├───RandomWord.php
│   │   ├───Story.php
│   │   ├───User.php
│   │   └───UserInactivityStatus.php
│   ├───Providers
│   └───Traits
│   │   └───WordCountTrait.php
├───bootstrap
│   └───cache
├───config
├───database
│    ├───factories
│    │       UserFactory.php
│    │       
│    ├───migrations
│    │       0001_01_01_000000_create_users_table.php
│    │       0001_01_01_000001_create_cache_table.php
│    │       0001_01_01_000002_create_jobs_table.php
│    │       2025_10_10_095825_create_stories_table.php
│    │       2025_10_19_162629_add_two_factor_columns_to_users_table.php
│    │       2025_10_29_072952_create_personal_access_tokens_table.php
│    │       2025_11_12_132255_create_random_words_table.php
│    │       2025_11_26_184153_create_user_inactivity_status_table.php
│    │       
│    └───seeders
│            DatabaseSeeder.php
│            RandomWordSeeder.php
│            StorySeeder.php
├───docs
├───public
├───resources
│   ├───css
│   ├───js
│   └───views
│       └───emails
│             ├───inactive_first.blade.php
│             └───inactive_second.blade.php
├───routes
│   ├───api.php
│   ├───console.php
│   └───web.php
├───storage
│   ├───app
│   │   ├───private
│   │   └───public
│   ├───framework
│   │   ├───cache
│   │   │   └───data
│   │   ├───sessions
│   │   ├───testing
│   │   └───views
│   └───logs
├───tests
│   ├───Feature
│   └───Unit
└───vendor


---

### 4.15. Comunicación Front–Back (resumen)

- Axios comunica Vue con Laravel.
- Interceptor añade token automáticamente.
- Pinia almacena usuario y token.
- Router protege rutas privadas.
- Backend devuelve JSON estructurado.
- Vue muestra errores y mensajes adecuados.
---

### 4.16. Estructura de carpetas del frontend (Vue)
├───node_modules 
├───public
├───src
│   ├───App.vue
│   ├───main.js
│   │
│   ├───assets
│   │       ├───style.css
│   │       ├───components
│   │       ├───Sidebar.vue
│   │       ├───router
│   │       ├───index.js
│   │       ├───services
│   │       ├───api.js
│   │       ├───stores
│   │       ├───auth.js
│   │       └───stories.js
│   │    
│   └───views
│       ├───DashboardView.vue
│       ├───LoginView.vue
│       ├───MainLayout.vue
│       ├───MainView.vue
│       ├───RegisterView.vue
│       ├───StoriesView.vue
│       └───StoryDetailView.vue
├───.gitignore                 
├───index.html            
├───jsconfig.json         
├───package-lock.json     
├───package.json          
├───postcss.config.js   
├───README.md           
├───tailwind.config.js  
└───vite.config.js 