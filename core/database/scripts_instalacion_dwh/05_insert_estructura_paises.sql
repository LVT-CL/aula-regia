
-- Insert data into `niveles_administrativos` dynamically based on `codigo_iso`

-- Argentina: Provincias > Departamentos > Localidades
INSERT INTO datawarehouse.niveles_administrativos (pais_id, nombre, nivel_jerarquico)
VALUES
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'AR'), 'Provincia', 1),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'AR'), 'Departamento', 2),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'AR'), 'Localidad', 3);

-- Bolivia: Departamentos > Provincias > Municipios
INSERT INTO datawarehouse.niveles_administrativos (pais_id, nombre, nivel_jerarquico)
VALUES
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'BO'), 'Departamento', 1),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'BO'), 'Provincia', 2),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'BO'), 'Municipio', 3);

-- Brasil: Estados > Mesorregiones > Microrregiones > Municipios
INSERT INTO datawarehouse.niveles_administrativos (pais_id, nombre, nivel_jerarquico)
VALUES
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'BR'), 'Estado', 1),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'BR'), 'Mesorregión', 2),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'BR'), 'Microrregión', 3),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'BR'), 'Municipio', 4);

-- Chile: Regiones > Provincias > Comunas
INSERT INTO datawarehouse.niveles_administrativos (pais_id, nombre, nivel_jerarquico)
VALUES
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'CL'), 'Región', 1),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'CL'), 'Provincia', 2),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'CL'), 'Comuna', 3);

-- Colombia: Departamentos > Municipios > Localidades
INSERT INTO datawarehouse.niveles_administrativos (pais_id, nombre, nivel_jerarquico)
VALUES
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'CO'), 'Departamento', 1),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'CO'), 'Municipio', 2),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'CO'), 'Localidad', 3);

-- Ecuador: Provincias > Cantones > Parroquias
INSERT INTO datawarehouse.niveles_administrativos (pais_id, nombre, nivel_jerarquico)
VALUES
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'EC'), 'Provincia', 1),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'EC'), 'Cantón', 2),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'EC'), 'Parroquia', 3);

-- Guyana: Regiones > Comunidades
INSERT INTO datawarehouse.niveles_administrativos (pais_id, nombre, nivel_jerarquico)
VALUES
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'GY'), 'Región', 1),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'GY'), 'Comunidad', 2);

-- Paraguay: Departamentos > Distritos > Barrios
INSERT INTO datawarehouse.niveles_administrativos (pais_id, nombre, nivel_jerarquico)
VALUES
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'PY'), 'Departamento', 1),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'PY'), 'Distrito', 2),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'PY'), 'Barrio', 3);

-- Perú: Regiones > Provincias > Distritos
INSERT INTO datawarehouse.niveles_administrativos (pais_id, nombre, nivel_jerarquico)
VALUES
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'PE'), 'Región', 1),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'PE'), 'Provincia', 2),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'PE'), 'Distrito', 3);

-- Surinam: Distritos > Ressorten
INSERT INTO datawarehouse.niveles_administrativos (pais_id, nombre, nivel_jerarquico)
VALUES
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'SR'), 'Distrito', 1),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'SR'), 'Ressort', 2);

-- Uruguay: Departamentos > Municipios > Localidades
INSERT INTO datawarehouse.niveles_administrativos (pais_id, nombre, nivel_jerarquico)
VALUES
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'UY'), 'Departamento', 1),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'UY'), 'Municipio', 2),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'UY'), 'Localidad', 3);

-- Venezuela: Estados > Municipios > Parroquias
INSERT INTO datawarehouse.niveles_administrativos (pais_id, nombre, nivel_jerarquico)
VALUES
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'VE'), 'Estado', 1),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'VE'), 'Municipio', 2),
    ((SELECT id FROM datawarehouse.paises WHERE codigo_iso = 'VE'), 'Parroquia', 3);
