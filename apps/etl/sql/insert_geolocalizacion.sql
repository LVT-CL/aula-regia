INSERT INTO pnl.geolocalizacion (domicilio_electoral, nombre_comuna, nombre_pais)
SELECT
    domicilio_electoral,
    nombre_comuna,
    'Chile'
FROM
    pnl.padron_servel
WHERE
    domicilio_electoral IS NOT NULL AND nombre_comuna IS NOT NULL
ON CONFLICT (domicilio_electoral, nombre_comuna)
DO NOTHING