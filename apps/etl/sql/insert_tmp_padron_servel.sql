INSERT INTO staging.tmp_padron_servel
SELECT
    "REGION" AS nombre_region,
    "REGION.1" AS numero_region,
    CASE WHEN "DISTRITO" = '-' THEN NULL ELSE
        LTRIM(SUBSTRING("DISTRITO", 9)) END::INT AS numero_distrito,
    "COMUNA" AS nombre_comuna,
    CAST("RUN" AS VARCHAR(10)) || '-' || CAST("DV" AS VARCHAR(1)) AS RUT,
    "NOMBRES" AS nombre,
    "APELLIDO_PATERNO" AS apellido_paterno,
    LTRIM(REPLACE(REPLACE("NOMBRE COMPLETO","NOMBRES",''),"APELLIDO_PATERNO",'')) AS apellido_materno,
    CASE "SEXO"
        WHEN 'VARON' THEN 'M'
        WHEN 'MUJER' THEN 'F'
    ELSE '-'
    END AS sexo,
    CAST("FECHA AFILIACION" AS DATE) AS fecha_afiliacion,
    TO_DATE("FECHA NACIMIENTO", 'DD-MM-YYYY') AS fecha_nacimiento,
    "DOMICILIO" AS domicilio_electoral,
    "CORREO" AS correo_electronico,
    "ID_ARCHIVO" AS id_archivo_fuente,
    TO_DATE("FECHA_PROCESO", 'YYYY-MM-DD HH24:MI:SS') AS fecha_proceso,
    TO_TIMESTAMP("FECHA_PROCESO", 'YYYY-MM-DD HH24:MI:SS') AS timestamp_proceso
FROM
    staging.var_padron_servel
WHERE
    "ID_ARCHIVO" = '{id_archivo}'