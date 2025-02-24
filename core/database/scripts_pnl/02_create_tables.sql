CREATE TABLE padron_servel (
    nombre_region VARCHAR(255),
    numero_region INT,
    numero_distrito INT,
    nombre_comuna VARCHAR(255),
    rut VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(255),
    apellido_paterno VARCHAR(255),
    apellido_materno VARCHAR(255),
    sexo VARCHAR(1),
    fecha_afiliacion DATE,
    fecha_nacimiento DATE,
    domicilio_electoral VARCHAR(255),
    correo_electronico VARCHAR(255),
    id_archivo_fuente VARCHAR(255),
    fecha_carga_bd DATE
);

CREATE TABLE geolocalizacion (
    id SERIAL PRIMARY KEY,
    domicilio_electoral VARCHAR(255) UNIQUE NOT NULL, -- Dirección exacta de búsqueda
    nombre_comuna VARCHAR(255) NOT NULL, -- Comuna para comparación
    nombre_pais VARCHAR(255) NOT NULL, -- País para comparación
    latitud DECIMAL(10, 8), -- Coordenada de latitud
    longitud DECIMAL(11, 8), -- Coordenada de longitud
    direccion_formateada TEXT, -- Dirección normalizada que devuelve la API
    location_type VARCHAR(50), -- Nivel de precisión de la API (ROOFTOP, GEOMETRIC_CENTER, etc.)
    fuente VARCHAR(50) NOT NULL DEFAULT 'Google', -- API de donde se obtuvo la información
    ultima_actualizacion TIMESTAMP DEFAULT NOW() -- Fecha de última actualización
);

CREATE UNIQUE INDEX idx_direccion_comuna ON geolocalizacion(domicilio_electoral, nombre_comuna);

CREATE TABLE pnl.zonas_coordinacion
(
    id SERIAL PRIMARY KEY,
    nombre_zona TEXT,
    numero_zona INT,
    comuna TEXT,
    numero_distrito INT
);

CREATE TABLE pnl.unidades_vecinales
(
    id SERIAL PRIMARY KEY,
    nombre_unidad_vecinal TEXT,
    numero_unidad_vecinal INT,
    comuna TEXT,
    georeferencia_id INT,
    poligono GEOMETRY(Polygon, 4326)
);

CREATE TABLE pnl.zona_unidad
(
    zona_id INT,
    unidad_vecinal_id INT
);

CREATE TABLE pnl.comunas (
    id SERIAL PRIMARY KEY,
    nombre_comuna VARCHAR(100),
    orden_comuna INT,
    nombre_provincia VARCHAR(200),
    numeracion_provincia INT,
    orden_provincia INT,
    nombre_region VARCHAR(200),
    numeracion_region INT,
    orden_region INT
);

INSERT INTO pnl.comunas (nombre_comuna, orden_comuna, nombre_provincia, numeracion_provincia, orden_provincia, nombre_region, numeracion_region, orden_region)
SELECT
    comunas.nombre,
    comunas.orden,
    provincias.nombre,
    provincias.numeracion,
    provincias.orden,
    regiones.nombre,
    regiones.numeracion,
    regiones.orden
FROM
    datawarehouse.paises
    INNER JOIN
    datawarehouse.niveles_administrativos
    ON
        paises.id = niveles_administrativos.pais_id
    INNER JOIN
    datawarehouse.unidades_administrativas comunas
    ON
        niveles_administrativos.id = comunas.nivel_id AND
        nivel_jerarquico = 3
    INNER JOIN
    datawarehouse.unidades_administrativas provincias
    ON
        comunas.unidad_superior_id = provincias.id
    INNER JOIN
    datawarehouse.unidades_administrativas regiones
    ON
        provincias.unidad_superior_id = regiones.id
WHERE
    paises.nombre = 'Chile'