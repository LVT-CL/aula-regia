CREATE TABLE tmp_padron_servel (
    nombre_region VARCHAR(255),
    numero_region INT,
    numero_distrito INT,
    nombre_comuna VARCHAR(255),
    rut VARCHAR(10),
    nombre VARCHAR(255),
    apellido_paterno VARCHAR(255),
    apellido_materno VARCHAR(255),
    sexo VARCHAR(1),
    fecha_afiliacion DATE,
    fecha_nacimiento DATE,
    domicilio_electoral VARCHAR(255),
    correo_electronico VARCHAR(255),
    id_archivo_fuente VARCHAR(255),
    fecha_proceso DATE,
    timestamp_proceso TIMESTAMP
)
    PARTITION BY LIST(id_archivo_fuente)
