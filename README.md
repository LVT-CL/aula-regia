
# Aula Regia

![Estado del Proyecto](https://img.shields.io/badge/STATUS-En%20Desarrollo-yellow)

## Índice

- [Descripción](#descripción)
- [Características](#características)
- [Tecnologías Utilizadas](#tecnologías-utilizadas)
- [Instalación](#instalación)
- [Uso](#uso)
- [Contribuciones](#contribuciones)
- [Licencia](#licencia)
- [Contacto](#contacto)

## Descripción

**Aula Regia** es una plataforma diseñada para gestionar comunidades, enfocándose en partidos políticos u organizaciones similares. Su objetivo es facilitar la administración de miembros, eventos y comunicaciones internas, promoviendo una gestión eficiente y transparente.

## Características

- Gestión de miembros: registro, actualización y seguimiento de la participación.
- Organización de eventos: planificación, difusión y control de asistencia.
- Comunicación interna: herramientas para mensajes y anuncios dirigidos.
- Informes y análisis: generación de reportes sobre actividades y participación.

## Tecnologías Utilizadas

- **Lenguajes de Programación:** Python, JavaScript
- **Frameworks:** Django (Backend), React (Frontend)
- **Bases de Datos:** PostgreSQL
- **Control de Versiones:** Git
- **Despliegue:** Docker, Kubernetes

## Instalación

Sigue estos pasos para configurar el entorno de desarrollo local:

1. **Clona el repositorio:**
   ```bash
   git clone https://github.com/LVT-CL/aula-regia.git
   ```
2. **Navega al directorio del proyecto:**
   ```bash
   cd aula-regia
   ```
3. **Configura el entorno virtual:**
   ```bash
   python -m venv env
   source env/bin/activate  # En Windows: env\Scripts\activate
   ```
4. **Instala las dependencias:**
   ```bash
   pip install -r requirements.txt
   ```
5. **Configura las variables de entorno:** Crea un archivo `.env` basado en `.env.example` y ajusta las variables según tu entorno.
6. **Realiza las migraciones de la base de datos:**
   ```bash
   python manage.py migrate
   ```
7. **Inicia el servidor de desarrollo:**
   ```bash
   python manage.py runserver
   ```

## Uso

Accede a la aplicación en `http://localhost:8000/` y utiliza las credenciales predeterminadas:

- **Usuario:** admin
- **Contraseña:** admin123

> **Nota:** Se recomienda cambiar las credenciales predeterminadas después del primer inicio de sesión por razones de seguridad.

## Contribuciones

¡Las contribuciones son bienvenidas! Si deseas colaborar:

1. Haz un fork del repositorio.
2. Crea una nueva rama con tu funcionalidad o corrección de errores:
   ```bash
   git checkout -b feature/nueva-funcionalidad
   ```
3. Realiza tus cambios y haz commit:
   ```bash
   git commit -m "Agrega nueva funcionalidad"
   ```
4. Sube tus cambios al repositorio remoto:
   ```bash
   git push origin feature/nueva-funcionalidad
   ```
5. Abre una Pull Request detallando tus cambios.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.

## Contacto

Para consultas o sugerencias:

- **Nombre:** Luciano Valenzuela
- **Correo Electrónico:** lucianovalenzuelat@gmail.com
- **LinkedIn:** https://www.linkedin.com/in/luciano-valenzuela-2a12b784/

---

> **Aula Regia** - Gestión eficiente para comunidades organizadas.
