```markdown
# Agatha - Backend API

Backend desarrollado en Laravel 12, encargado de gestionar:

- API REST de usuarios e historias
- Autenticación con Sanctum
- Generación aleatoria de palabras y lugares
- Envío de emails por inactividad (7 y 25 días)
- Console Command + Scheduler
- Validaciones y seguridad
- Recursos API (StoryResource)

## Instalación y configuración

### Requisitos

- PHP 8.2 o superior
- Composer
- MySQL / MariaDB
- Laragon / XAMPP / Laravel Sail
- Extensiones PHP: openssl, mbstring, pdo, tokenizer, xml

### Clonar el repositorio

```bash
git clone https://github.com/usuario/agatha-backend.git
cd agatha-backend
```

### Instalar dependencias

```bash
composer install
```

### Copiar y configurar archivo .env

```bash
cp .env.example .env
```

Editar los parámetros básicos en .env:

```env
APP_NAME=Agatha
APP_URL=http://agatha-api.test

DB_DATABASE=agatha
DB_USERNAME=root
DB_PASSWORD=
```

### Generar clave de Laravel

```bash
php artisan key:generate
```

### Importar la base de datos (OBLIGATORIO)

Instrucciones:

1. Abrir phpMyAdmin o la herramienta correspondiente
2. Crear la base de datos agatha
3. Ir a la pestaña Importar
4. Seleccionar el archivo agatha.sql del directorio public
5. Hacer clic en Aceptar

Incluye usuarios de prueba, historias, palabras, lugares y estado de inactividad.

### (Opcional) Generar tablas desde migraciones

```bash
php artisan migrate --seed
```

### Ejecutar servidor

```bash
php artisan serve
```

Con Laragon estará disponible en: http://agatha-api.test

## Endpoints principales

### Auth

| Método | Ruta                | Descripción              |
|--------|---------------------|--------------------------|
| POST   | /api/register       | Registro de usuario      |
| POST   | /api/login          | Login (devuelve token)   |
| POST   | /api/logout         | Cerrar sesión            |
| GET    | /api/me             | Datos del usuario actual |
| PUT    | /api/user           | Actualizar perfil        |

### Historias

| Método | Ruta                          | Descripción                  |
|--------|-------------------------------|------------------------------|
| GET    | /api/story/list               | Listado de historias         |
| GET    | /api/story/show?storyToken=   | Mostrar una historia         |
| POST   | /api/story/store              | Crear historia               |
| PUT    | /api/story/update             | Actualizar historia          |
| DELETE | /api/story/destroy            | Eliminar historia            |
| GET    | /api/story/random             | Historia aleatoria           |

## Avisos automáticos por inactividad

Comando:

```bash
php artisan users:check-inactive
```

Programado en app/Console/Kernel.php:

```php
$schedule->command('users:check-inactive')->daily();
```

Envía emails a los 7 y 25 días de inactividad.