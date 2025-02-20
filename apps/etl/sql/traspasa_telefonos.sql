INSERT INTO
    tmp_planilla_telefonos
SELECT
    var_formulario_bienvenida.rut,
    '+569'||RIGHT(REPLACE(var_formulario_bienvenida.telefono,' ',''),8),
    'bienvenida',
    '2025-02-19'
FROM
    var_formulario_bienvenida
    LEFT JOIN
    tmp_planilla_telefonos
    ON
        tmp_planilla_telefonos.rut=var_formulario_bienvenida.rut
WHERE
    tmp_planilla_telefonos.rut IS NULL