
DROP VIEW pnl.militantes_zona;

CREATE VIEW pnl.militantes_zona AS
SELECT
    servel.rut,
    servel.nombre,
    servel.apellido_paterno,
    servel.apellido_materno,
    servel.fecha_afiliacion,
    EXTRACT(YEAR FROM AGE(NOW(), servel.fecha_nacimiento)) AS edad,
    servel.sexo,
    servel.correo_electronico,
    telefonos.telefono,
    formulario.profesion,
    servel.domicilio_electoral,
    servel.nombre_region,
    servel.numero_distrito,
    servel.nombre_comuna,
    unidad.nombre_unidad_vecinal,
    zonas.nombre_zona,
    formulario.motivacion,
    formulario.militancia_previa,
    formulario.candidatura_previa,
    formulario.cargo_candidatura_previa,
    formulario.estado_civil,
    formulario.solo_firma,
    formulario.quiere_militar,
    formulario.quiere_aportar_con_profesion,
    formulario.quiere_coordinar,
    formulario.quiere_ser_comunicador,
    formulario.quiere_ser_candidato
FROM
    pnl.padron_servel servel
    INNER JOIN
    pnl.geolocalizacion geo
    ON
        servel.domicilio_electoral = geo.domicilio_electoral AND
        servel.nombre_comuna = geo.nombre_comuna
    LEFT JOIN
    pnl.unidades_vecinales unidad
    ON
        datawarehouse.ST_Contains(poligono, datawarehouse.ST_SetSRID(datawarehouse.ST_Point(longitud, latitud), 4326))
    LEFT JOIN
    pnl.zona_unidad z_u
    ON
        unidad.id = z_u.unidad_vecinal_id
    LEFT JOIN
    pnl.zonas_coordinacion zonas
    ON
        z_u.zona_id = zonas.id
    LEFT JOIN
    staging.tmp_planilla_telefonos telefonos
    ON
        servel.rut = telefonos.rut
    LEFT JOIN
    staging.tmp_formulario_bienvenida formulario
    ON
        servel.rut = formulario.rut