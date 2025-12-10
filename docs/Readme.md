# Agatha – Plataforma Creativa de Escritura

Este repositorio contiene el proyecto **Agatha**, una aplicación web diseñada para motivar la escritura creativa mediante retos diarios, palabras aleatorias y un sistema automatizado de recordatorios por inactividad.

Incluye:

- Backend desarrollado en **Laravel 12**
- Frontend desarrollado en **Vue 3**
- Base de datos MySQL
- Documentación completa del proyecto en Markdown
- Herramientas para generar un **libro PDF** de la memoria y una **presentación HTML** con Marp

---

## 📘 Generar el libro en PDF (Memoria del proyecto)

La memoria está dividida en varios archivos Markdown, uno por capítulo:

00-introduccion.md
01-tecnologias.md
02-analisis.md
03-implementacion.md
04-conclusiones.md
05-bibliografia.md


Para generar la memoria en **formato libro PDF**, utiliza este comando:

```bash
docker run --rm \
       --volume "$(pwd):/data" \
       --user $(id -u):$(id -g) \
       pandoc/extra 0?-*.md -o \
       Agatha-Memoria.pdf --template eisvogel --listings --number-sections
```

Esto generará:
Agatha-Memoria.pdf

Con:
- Portada automática
- Índice de contenidos
- Numeración de secciones
- Formato profesional (plantilla Eisvogel)
- Generar la presentación en HTML (diapositivas del proyecto)

Dentro de la carpeta:
/diapositivas/presentacion.md

Puedes generar la presentación HTML con:

docker run --rm -v $PWD:/home/marp/app/ \
       -e LANG=$LANG \
       -e MARP_USER="$(id -u):$(id -g)" \
       marpteam/marp-cli presentacion.md


Esto genera:
presentacion.html

Que puedes abrir en el navegador o proyectar directamente en clase.