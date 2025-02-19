CREATE VIEW pnl.militantes_zona AS
SELECT
    servel.rut,
    servel.nombre,
    servel.apellido_paterno,
    servel.apellido_materno,
    servel.fecha_afiliacion,
    EXTRACT(YEAR FROM AGE(NOW(), servel.fecha_nacimiento)) AS edad,
    servel.correo_electronico,
    servel.domicilio_electoral,
    servel.nombre_region,
    servel.numero_distrito,
    servel.nombre_comuna,
    unidad.nombre_unidad_vecinal,
    zonas.nombre_zona
FROM
    pnl.padron_servel servel
    INNER JOIN
    pnl.geolocalizacion geo
    ON
        servel.domicilio_electoral = geo.domicilio_electoral
    LEFT JOIN
    pnl.unidades_vecinales unidad
    ON
        ST_Contains(poligono, ST_SetSRID(ST_Point(longitud, latitud), 4326))
    LEFT JOIN
    pnl.zona_unidad z_u
    ON
        unidad.id = z_u.unidad_vecinal_id
    LEFT JOIN
    pnl.zonas_coordinacion zonas
    ON
        z_u.zona_id = zonas.id