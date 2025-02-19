INSERT INTO padron_servel
SELECT
    nombre_region,
    numero_region,
    numero_distrito,
    nombre_comuna,
    rut,
    nombre,
    apellido_paterno,
    apellido_materno,
    sexo,
    fecha_afiliacion,
    fecha_nacimiento,
    domicilio_electoral,
    correo_electronico,
    id_archivo_fuente,
    fecha_proceso
FROM
    staging.tmp_padron_servel
WHERE
    id_archivo_fuente = '{id_archivo}'
ON CONFLICT (rut)
DO UPDATE SET
              nombre_region = EXCLUDED.nombre_region,
              numero_region = EXCLUDED.numero_region,
              numero_distrito = EXCLUDED.numero_distrito,
              nombre_comuna = EXCLUDED.nombre_comuna,
              fecha_afiliacion = EXCLUDED.fecha_afiliacion,
              domicilio_electoral = EXCLUDED.domicilio_electoral,
              correo_electronico = EXCLUDED.correo_electronico