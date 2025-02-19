CREATE EXTENSION postgis;
-- enabling raster support
CREATE EXTENSION postgis_raster;

-- enabling advanced 3d support
CREATE EXTENSION postgis_sfcgal;
-- enabling SQL/MM Net Topology
CREATE EXTENSION postgis_topology;

-- using US census data for geocoding and standardization
CREATE EXTENSION address_standardizer;
CREATE EXTENSION fuzzystrmatch;
CREATE EXTENSION postgis_tiger_geocoder;

CREATE TABLE zonas_geoespaciales (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    tipo_zona_id INT,
    area GEOMETRY(Polygon, 4326) -- Para datos geográficos
);

CREATE TABLE tipos_zona_geoespacial (
    id INT,
    descripcion TEXT
);
