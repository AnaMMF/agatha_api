---
marp: true
theme: gaia
paginate: true
---

# 3. Análisis

En este capítulo se recogen los elementos clave que definen cómo debe funcionar la aplicación Agatha a nivel funcional y estructural. Incluye los casos de uso principales, el diagrama entidad-relación lógico de la base de datos y varios diagramas que ayudan a entender los flujos internos, como el sistema automático de avisos por inactividad.

---

### 3.1. Casos de Uso

A continuación se representan los casos de uso básicos del sistema, centrándonos en la interacción entre el usuario y la plataforma.

---
![Diagrama casos de uso](Uso.drawio.svg)

---

### 3.2. Diagrama Entidad-Relación (Versión Lógica)

Este diagrama representa la estructura principal de la base de datos utilizada en Agatha. Está adaptado al modelo real del proyecto.

---
![Diagrama entidad.relación BBDD](E-R_BBDD.drawio.svg)

---

### 3.3. Diagrama de Estados (Actividad del usuario)

Este diagrama muestra cómo evoluciona el estado de un usuario dentro del sistema en función de su actividad al escribir historias. Es especialmente ilustrativo para entender el sistema automático de correos.
![alt text](Inactividad.drawio.svg)

---
### 3.4. Diagrama de Secuencia (Proceso de envío automático)

Este diagrama explica cómo se ejecuta el comando users:check-inactive y cómo se envían los correos.

---

![alt text](Envio.drawio.svg)

---

### 3.5. Requisitos del Proyecto
Requisitos funcionales:
  - El usuario debe poder registrarse, iniciar y cerrar sesión.
  - El usuario puede escribir nuevas historias.
  - Puede consultar la lista de historias escritas.
  - Puede ver el detalle de una historia.
  - Puede editar o eliminar historias.
  - El sistema debe enviar un email tras 7 días sin actividad.
  - El sistema debe enviar un segundo email tras 25 días sin actividad.
  - Los correos deben enviarse solo una vez por cada periodo.

---

Requisitos no funcionales:
  - La API debe seguir el estándar REST.
  - La base de datos debe garantizar integridad y relaciones.
  - La aplicación debe ser segura mediante tokens Sanctum.
  - Debe ser desplegable tanto en entorno local como remoto.
  - Los tiempos de respuesta deben ser inferiores a 200ms en operaciones básicas.