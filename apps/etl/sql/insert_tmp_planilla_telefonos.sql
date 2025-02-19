INSERT INTO
staging.tmp_planilla_telefonos
SELECT
    "RUN"||'-'||UPPER("DV"),
    '+569'||RIGHT(TRIM(regexp_replace("TELÉFONO", '[^0-9]', '', 'g')),8),
    "ID_ARCHIVO",
    TO_DATE("FECHA_PROCESO", 'YYYY-MM-DD HH24:MI:SS')
FROM
    staging.var_planilla_telefonos
WHERE
    LEFT("TELÉFONO",2) != '+1'