# 6. Bibliografía

A continuación se recoge una lista de los recursos, documentación, tutoriales y materiales que han servido de apoyo durante el desarrollo del proyecto Agatha, junto a una breve descripción de qué se aprendió con cada uno.

- **Documentación oficial de Laravel**  
  https://laravel.com/docs  
  Guía principal para entender controladores, modelos, migraciones, rutas, mailables, colas, scheduler y configuración general del framework.

- **Laravel Sanctum – Autenticación mediante tokens**  
  https://laravel.com/docs/sanctum  
  Me permitió aprender cómo funciona la generación y validación de tokens personales, así como la protección de rutas con `auth:sanctum`.

- **Eloquent ORM – Relaciones y consultas**  
  https://laravel.com/docs/eloquent  
  Recurso clave para aprender a trabajar con relaciones (`hasMany`, `belongsTo`, `hasOne`), consultas avanzadas y formateo de atributos desde el modelo.

- **Mailtrap – Testing de envío de correos**  
  https://mailtrap.io/  
  Utilizado para probar el envío real de correos sin necesidad de usar un servidor SMTP de producción. También ayudó a entender límites de envío y manejo de errores SMTP.

- **Laravel Scheduler (tareas programadas)**  
  https://laravel.com/docs/scheduling  
  Fundamental para implementar el sistema automático de avisos por inactividad mediante `php artisan schedule:work` y comandos personalizados.

- **Markdown para documentación técnica**  
  https://www.markdownguide.org/basic-syntax/  
  Referencia para estructurar la documentación y entender cómo formatear tablas, listas, código y títulos.

- **UUID y manejo de cadenas en Laravel**  
  https://laravel.com/docs/helpers  
  Sirvió para generar tokens únicos (`Str::uuid()`) y manipular cadenas y fechas.

- **Carbon – Manejo de fechas en PHP**  
  https://carbon.nesbot.com/docs/  
  Recurso clave para trabajar con intervalos de tiempo, diferencias en días, formateo de fechas y operaciones complejas con timestamps.

- **Diagrams.net (Draw.io)**  
  https://app.diagrams.net/  
  Utilizado para realizar casos de uso, diagramas de clases y diagramas de flujo de manera visual y exportable a Markdown o imagen.

- **PHP The Right Way**  
  https://phptherightway.com/  
  Ayudó a entender buenas prácticas generales en PHP, estándares de código y patrones comunes.

- **StackOverflow**  
  https://stackoverflow.com/  
  Fuente de soluciones rápidas a errores concretos relacionados con SMTP, migraciones, relaciones mal definidas y problemas comunes con el scheduler.


