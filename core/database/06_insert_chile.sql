DO $$
DECLARE
    chile_id INT;
    estructura_region_id INT;
    estructura_provincia_id INT;
    estructura_comuna_id INT;

    -- Identificadores de Región
    region_arica INT;
    region_tarapaca INT;
    region_antofagasta INT;
    region_atacama INT;
    region_coquimbo INT;
    region_valparaiso INT;
    region_metropolitana INT;
    region_ohiggins INT;
    region_maule INT;
    region_nuble INT;
    region_biobio INT;
    region_araucania INT;
    region_losrios INT;
    region_loslagos INT;
    region_aysen INT;
    region_magallanes INT;

    -- Regiones de Arica y Parinacota
    provincia_arica INT;
    provincia_parinacota INT;

    -- Región de Tarapacá
    provincia_iquique INT;
    provincia_tamarugal INT;

    -- Región de Antofagasta
    provincia_antofagasta INT;
    provincia_eloa INT;
    provincia_tocopilla INT;

    -- Región de Atacama
    provincia_copiapo INT;
    provincia_chañaral INT;
    provincia_huasco INT;

    -- Región de Coquimbo
    provincia_elqui INT;
    provincia_limari INT;
    provincia_choapa INT;

    -- Región de Valparaíso
    provincia_valparaiso INT;
    provincia_isla_pascua INT;
    provincia_quillota INT;
    provincia_marga_marga INT;
    provincia_san_antonio INT;
    provincia_petorca INT;
    provincia_los_andes INT;
    provincia_san_felipe_de_aconcagua INT;

    -- Región Metropolitana
    provincia_santiago INT;
    provincia_chacabuco INT;
    provincia_maipo INT;
    provincia_cordillera INT;
    provincia_talagante INT;
    provincia_melipilla INT;

    -- Región de O'Higgins
    provincia_cachapoal INT;
    provincia_colchagua INT;
    provincia_cardenal_caro INT;

    -- Región del Maule
    provincia_talca INT;
    provincia_curico INT;
    provincia_linares INT;
    provincia_cauquenes INT;

    -- Región de Ñuble
    provincia_diguillin INT;
    provincia_punilla INT;
    provincia_itata INT;

    -- Región del Biobío
    provincia_concepcion INT;
    provincia_arauco INT;
    provincia_bio_bio INT;

    -- Región de La Araucanía
    provincia_cautin INT;
    provincia_malleco INT;

    -- Región de Los Ríos
    provincia_valdivia INT;
    provincia_ranco INT;

    -- Región de Los Lagos
    provincia_llanquihue INT;
    provincia_osorno INT;
    provincia_chiloe INT;
    provincia_palena INT;

    -- Región de Aysén
    provincia_aysen INT;
    provincia_coyhaique INT;
    provincia_capitan_prat INT;
    provincia_gral_carrera INT;

    -- Región de Magallanes y la Antártica Chilena
    provincia_magallanes INT;
    provincia_antartica_chilena INT;
    provincia_tierra_del_fuego INT;
    provincia_ultima_esperanza INT;

BEGIN
    -- Set search path to datawarehouse schema
    SET search_path TO datawarehouse;

    -- Fetch and store country identifier in a variable
    SELECT id INTO chile_id FROM paises WHERE codigo_iso = 'CL';

    -- Fetch and store structure level identifier for "Región"
    SELECT id INTO estructura_region_id
    FROM estructura_niveles
    WHERE pais_id = chile_id AND nombre = 'Región';

    -- Fetch and store structure level identifier for "Provincia"
    SELECT id INTO estructura_provincia_id
    FROM estructura_niveles
    WHERE pais_id = chile_id AND nombre = 'Provincia';

    -- Fetch and store structure level identifier for "Comuna"
    SELECT id INTO estructura_comuna_id
    FROM estructura_niveles
    WHERE pais_id = chile_id AND nombre = 'Comuna';

    -- Insert regions for Chile
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_region_id, 'Región de Arica y Parinacota', 15, 1, NULL),
        (estructura_region_id, 'Región de Tarapacá', 1, 2, NULL),
        (estructura_region_id, 'Región de Antofagasta', 2, 3, NULL),
        (estructura_region_id, 'Región de Atacama', 3, 4, NULL),
        (estructura_region_id, 'Región de Coquimbo', 4, 5, NULL),
        (estructura_region_id, 'Región de Valparaíso', 5, 6, NULL),
        (estructura_region_id, 'Región Metropolitana de Santiago', 13, 7, NULL),
        (estructura_region_id, 'Región del Libertador General Bernardo O’Higgins', 6, 8, NULL),
        (estructura_region_id, 'Región del Maule', 7, 9, NULL),
        (estructura_region_id, 'Región del Ñuble', 16, 10, NULL),
        (estructura_region_id, 'Región del Biobío', 8, 11, NULL),
        (estructura_region_id, 'Región de la Araucanía', 9, 12, NULL),
        (estructura_region_id, 'Región de Los Ríos', 14, 13, NULL),
        (estructura_region_id, 'Región de Los Lagos', 10, 14, NULL),
        (estructura_region_id, 'Región de Aysén del General Carlos Ibáñez del Campo', 11, 15, NULL),
        (estructura_region_id, 'Región de Magallanes y de la Antártica Chilena', 12, 16, NULL);



    -- Fetch and store region identifiers in variables
    SELECT id INTO region_arica FROM niveles_administrativos WHERE nombre = 'Región de Arica y Parinacota';
    SELECT id INTO region_tarapaca FROM niveles_administrativos WHERE nombre = 'Región de Tarapacá';
    SELECT id INTO region_antofagasta FROM niveles_administrativos WHERE nombre = 'Región de Antofagasta';
    SELECT id INTO region_atacama FROM niveles_administrativos WHERE nombre = 'Región de Atacama';
    SELECT id INTO region_coquimbo FROM niveles_administrativos WHERE nombre = 'Región de Coquimbo';
    SELECT id INTO region_valparaiso FROM niveles_administrativos WHERE nombre = 'Región de Valparaíso';
    SELECT id INTO region_metropolitana FROM niveles_administrativos WHERE nombre = 'Región Metropolitana de Santiago';
    SELECT id INTO region_ohiggins FROM niveles_administrativos WHERE nombre = 'Región del Libertador General Bernardo O’Higgins';
    SELECT id INTO region_maule FROM niveles_administrativos WHERE nombre = 'Región del Maule';
    SELECT id INTO region_nuble FROM niveles_administrativos WHERE nombre = 'Región del Ñuble';
    SELECT id INTO region_biobio FROM niveles_administrativos WHERE nombre = 'Región del Biobío';
    SELECT id INTO region_araucania FROM niveles_administrativos WHERE nombre = 'Región de la Araucanía';
    SELECT id INTO region_losrios FROM niveles_administrativos WHERE nombre = 'Región de Los Ríos';
    SELECT id INTO region_loslagos FROM niveles_administrativos WHERE nombre = 'Región de Los Lagos';
    SELECT id INTO region_aysen FROM niveles_administrativos WHERE nombre = 'Región de Aysén del General Carlos Ibáñez del Campo';
    SELECT id INTO region_magallanes FROM niveles_administrativos WHERE nombre = 'Región de Magallanes y de la Antártica Chilena';

    -- Insert provinces for each region
    -- Región de Arica y Parinacota
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Arica', 1, 1, region_arica),
        (estructura_provincia_id, 'Provincia de Parinacota', 2, 2, region_arica);

    -- Región de Tarapacá
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Iquique', 3, 1, region_tarapaca),
        (estructura_provincia_id, 'Provincia del Tamarugal', 4, 2, region_tarapaca);

    -- Región de Antofagasta
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Antofagasta', 5, 1, region_antofagasta),
        (estructura_provincia_id, 'Provincia de El Loa', 6, 2, region_antofagasta),
        (estructura_provincia_id, 'Provincia de Tocopilla', 7, 3, region_antofagasta);

    -- Región de Atacama
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Copiapó', 8, 1, region_atacama),
        (estructura_provincia_id, 'Provincia de Chañaral', 9, 2, region_atacama),
        (estructura_provincia_id, 'Provincia de Huasco', 10, 3, region_atacama);

    -- Región de Coquimbo
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Elqui', 11, 1, region_coquimbo),
        (estructura_provincia_id, 'Provincia de Choapa', 12, 2, region_coquimbo),
        (estructura_provincia_id, 'Provincia de Limarí', 13, 3, region_coquimbo);

    -- Región de Valparaíso
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Valparaíso', 14, 1, region_valparaiso),
        (estructura_provincia_id, 'Provincia de Isla de Pascua', 15, 2, region_valparaiso),
        (estructura_provincia_id, 'Provincia de Los Andes', 16, 3, region_valparaiso),
        (estructura_provincia_id, 'Provincia de Petorca', 17, 4, region_valparaiso),
        (estructura_provincia_id, 'Provincia de Quillota', 18, 5, region_valparaiso),
        (estructura_provincia_id, 'Provincia de San Antonio', 19, 6, region_valparaiso),
        (estructura_provincia_id, 'Provincia de San Felipe de Aconcagua', 20, 7, region_valparaiso),
        (estructura_provincia_id, 'Provincia de Marga Marga', 21, 8, region_valparaiso);

    -- Región del Libertador General Bernardo O’Higgins
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Cachapoal', 22, 1, region_ohiggins),
        (estructura_provincia_id, 'Provincia de Cardenal Caro', 23, 2, region_ohiggins),
        (estructura_provincia_id, 'Provincia de Colchagua', 24, 3, region_ohiggins);

    -- Región del Maule
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Talca', 25, 1, region_maule),
        (estructura_provincia_id, 'Provincia de Cauquenes', 26, 2, region_maule),
        (estructura_provincia_id, 'Provincia de Curicó', 27, 3, region_maule),
        (estructura_provincia_id, 'Provincia de Linares', 28, 4, region_maule);

    -- Región de Ñuble
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Diguillín', 29, 1, region_nuble),
        (estructura_provincia_id, 'Provincia de Itata', 30, 2, region_nuble),
        (estructura_provincia_id, 'Provincia de Punilla', 31, 3, region_nuble);

    -- Región del Biobío
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Concepción', 32, 1, region_biobio),
        (estructura_provincia_id, 'Provincia de Arauco', 33, 2, region_biobio),
        (estructura_provincia_id, 'Provincia del Biobío', 34, 3, region_biobio);

    -- Región de la Araucanía
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Cautín', 35, 1, region_araucania),
        (estructura_provincia_id, 'Provincia de Malleco', 36, 2, region_araucania);

    -- Región de Los Ríos
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Valdivia', 37, 1, region_losrios),
        (estructura_provincia_id, 'Provincia del Ranco', 38, 2, region_losrios);

    -- Región de Los Lagos
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Llanquihue', 39, 1, region_loslagos),
        (estructura_provincia_id, 'Provincia de Chiloé', 40, 2, region_loslagos),
        (estructura_provincia_id, 'Provincia de Osorno', 41, 3, region_loslagos),
        (estructura_provincia_id, 'Provincia de Palena', 42, 4, region_loslagos);

    -- Región de Aysén del General Carlos Ibáñez del Campo
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Coyhaique', 43, 1, region_aysen),
        (estructura_provincia_id, 'Provincia de Aysén', 44, 2, region_aysen),
        (estructura_provincia_id, 'Provincia de Capitán Prat', 45, 3, region_aysen),
        (estructura_provincia_id, 'Provincia de General Carrera', 46, 4, region_aysen);

    -- Región de Magallanes y de la Antártica Chilena
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Magallanes', 47, 1, region_magallanes),
        (estructura_provincia_id, 'Provincia de Antártica Chilena', 48, 2, region_magallanes),
        (estructura_provincia_id, 'Provincia de Tierra del Fuego', 49, 3, region_magallanes),
        (estructura_provincia_id, 'Provincia de Última Esperanza', 50, 4, region_magallanes);

    -- Región Metropolitana de Santiago
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_provincia_id, 'Provincia de Santiago', 51, 1, region_metropolitana),
        (estructura_provincia_id, 'Provincia de Cordillera', 52, 2, region_metropolitana),
        (estructura_provincia_id, 'Provincia de Chacabuco', 53, 3, region_metropolitana),
        (estructura_provincia_id, 'Provincia de Maipo', 54, 4, region_metropolitana),
        (estructura_provincia_id, 'Provincia de Melipilla', 55, 5, region_metropolitana),
        (estructura_provincia_id, 'Provincia de Talagante', 56, 6, region_metropolitana);

    -- Fetch and store province identifiers for Arica y Parinacota
    SELECT id INTO provincia_arica FROM niveles_administrativos WHERE nombre = 'Provincia de Arica';
    SELECT id INTO provincia_parinacota FROM niveles_administrativos WHERE nombre = 'Provincia de Parinacota';

    -- Fetch and store province identifiers for Tarapacá
    SELECT id INTO provincia_iquique FROM niveles_administrativos WHERE nombre = 'Provincia de Iquique';
    SELECT id INTO provincia_tamarugal FROM niveles_administrativos WHERE nombre = 'Provincia del Tamarugal';

    -- Fetch and store province identifiers for Antofagasta
    SELECT id INTO provincia_antofagasta FROM niveles_administrativos WHERE nombre = 'Provincia de Antofagasta';
    SELECT id INTO provincia_eloa FROM niveles_administrativos WHERE nombre = 'Provincia de El Loa';
    SELECT id INTO provincia_tocopilla FROM niveles_administrativos WHERE nombre = 'Provincia de Tocopilla';

    -- Fetch and store province identifiers for Atacama
    SELECT id INTO provincia_copiapo FROM niveles_administrativos WHERE nombre = 'Provincia de Copiapó';
    SELECT id INTO provincia_chañaral FROM niveles_administrativos WHERE nombre = 'Provincia de Chañaral';
    SELECT id INTO provincia_huasco FROM niveles_administrativos WHERE nombre = 'Provincia de Huasco';

    -- Fetch and store province identifiers for Región de Coquimbo
    SELECT id INTO provincia_elqui FROM niveles_administrativos WHERE nombre = 'Provincia de Elqui';
    SELECT id INTO provincia_limari FROM niveles_administrativos WHERE nombre = 'Provincia de Limarí';
    SELECT id INTO provincia_choapa FROM niveles_administrativos WHERE nombre = 'Provincia de Choapa';

    -- Fetch and store province identifiers for Región de Valparaíso
    SELECT id INTO provincia_valparaiso FROM niveles_administrativos WHERE nombre = 'Provincia de Valparaíso';
    SELECT id INTO provincia_quillota FROM niveles_administrativos WHERE nombre = 'Provincia de Quillota';
    SELECT id INTO provincia_marga_marga FROM niveles_administrativos WHERE nombre = 'Provincia de Marga Marga';
    SELECT id INTO provincia_san_antonio FROM niveles_administrativos WHERE nombre = 'Provincia de San Antonio';
    SELECT id INTO provincia_los_andes FROM niveles_administrativos WHERE nombre = 'Provincia de Los Andes';
    SELECT id INTO provincia_petorca FROM niveles_administrativos WHERE nombre = 'Provincia de Petorca';
    SELECT id INTO provincia_san_felipe_de_aconcagua FROM niveles_administrativos WHERE nombre = 'Provincia de San Felipe de Aconcagua';
    SELECT id INTO provincia_isla_pascua FROM niveles_administrativos WHERE nombre = 'Provincia de Isla de Pascua';

    -- Fetch and store province identifiers for Región Metropolitana
    SELECT id INTO provincia_santiago FROM niveles_administrativos WHERE nombre = 'Provincia de Santiago';
    SELECT id INTO provincia_chacabuco FROM niveles_administrativos WHERE nombre = 'Provincia de Chacabuco';
    SELECT id INTO provincia_maipo FROM niveles_administrativos WHERE nombre = 'Provincia de Maipo';
    SELECT id INTO provincia_cordillera FROM niveles_administrativos WHERE nombre = 'Provincia de Cordillera';
    SELECT id INTO provincia_talagante FROM niveles_administrativos WHERE nombre = 'Provincia de Talagante';
    SELECT id INTO provincia_melipilla FROM niveles_administrativos WHERE nombre = 'Provincia de Melipilla';

    -- Fetch and store province identifiers for Región de O'Higgins
    SELECT id INTO provincia_cachapoal FROM niveles_administrativos WHERE nombre = 'Provincia de Cachapoal';
    SELECT id INTO provincia_colchagua FROM niveles_administrativos WHERE nombre = 'Provincia de Colchagua';
    SELECT id INTO provincia_cardenal_caro FROM niveles_administrativos WHERE nombre = 'Provincia Cardenal Caro';

    -- Fetch and store province identifiers for Región del Maule
    SELECT id INTO provincia_talca FROM niveles_administrativos WHERE nombre = 'Provincia de Talca';
    SELECT id INTO provincia_curico FROM niveles_administrativos WHERE nombre = 'Provincia de Curicó';
    SELECT id INTO provincia_linares FROM niveles_administrativos WHERE nombre = 'Provincia de Linares';
    SELECT id INTO provincia_cauquenes FROM niveles_administrativos WHERE nombre = 'Provincia de Cauquenes';

    -- Fetch and store province identifiers for Región de Ñuble
    SELECT id INTO provincia_diguillin FROM niveles_administrativos WHERE nombre = 'Provincia de Diguillín';
    SELECT id INTO provincia_punilla FROM niveles_administrativos WHERE nombre = 'Provincia de Punilla';
    SELECT id INTO provincia_itata FROM niveles_administrativos WHERE nombre = 'Provincia de Itata';

    -- Fetch and store province identifiers for Región del Biobío
    SELECT id INTO provincia_concepcion FROM niveles_administrativos WHERE nombre = 'Provincia de Concepción';
    SELECT id INTO provincia_arauco FROM niveles_administrativos WHERE nombre = 'Provincia de Arauco';
    SELECT id INTO provincia_bio_bio FROM niveles_administrativos WHERE nombre = 'Provincia del Biobío';

    -- Fetch and store province identifiers for Región de La Araucanía
    SELECT id INTO provincia_cautin FROM niveles_administrativos WHERE nombre = 'Provincia de Cautín';
    SELECT id INTO provincia_malleco FROM niveles_administrativos WHERE nombre = 'Provincia de Malleco';

    -- Fetch and store province identifiers for Región de Los Ríos
    SELECT id INTO provincia_valdivia FROM niveles_administrativos WHERE nombre = 'Provincia de Valdivia';
    SELECT id INTO provincia_ranco FROM niveles_administrativos WHERE nombre = 'Provincia del Ranco';

    -- Fetch and store province identifiers for Región de Los Lagos
    SELECT id INTO provincia_llanquihue FROM niveles_administrativos WHERE nombre = 'Provincia de Llanquihue';
    SELECT id INTO provincia_osorno FROM niveles_administrativos WHERE nombre = 'Provincia de Osorno';
    SELECT id INTO provincia_chiloe FROM niveles_administrativos WHERE nombre = 'Provincia de Chiloé';
    SELECT id INTO provincia_palena FROM niveles_administrativos WHERE nombre = 'Provincia de Palena';

    -- Fetch and store province identifiers for Región de Aysén
    SELECT id INTO provincia_aysen FROM niveles_administrativos WHERE nombre = 'Provincia de Aysén';
    SELECT id INTO provincia_coyhaique FROM niveles_administrativos WHERE nombre = 'Provincia de Coyhaique';
    SELECT id INTO provincia_capitan_prat FROM niveles_administrativos WHERE nombre = 'Provincia de Capitán Prat';
    SELECT id INTO provincia_gral_carrera FROM niveles_administrativos WHERE nombre = 'Provincia General Carrera';

    -- Fetch and store province identifiers for Región de Magallanes y la Antártica Chilena
    SELECT id INTO provincia_magallanes FROM niveles_administrativos WHERE nombre = 'Provincia de Magallanes';
    SELECT id INTO provincia_antartica_chilena FROM niveles_administrativos WHERE nombre = 'Provincia de Antártica Chilena';
    SELECT id INTO provincia_tierra_del_fuego FROM niveles_administrativos WHERE nombre = 'Provincia de Tierra del Fuego';
    SELECT id INTO provincia_ultima_esperanza FROM niveles_administrativos WHERE nombre = 'Provincia de Última Esperanza';

    -- Insert comunas for Región de Arica y Parinacota
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_comuna_id, 'Comuna de Arica', NULL, 1, provincia_arica),
        (estructura_comuna_id, 'Comuna de Camarones', NULL, 2, provincia_arica),
        (estructura_comuna_id, 'Comuna de Putre', NULL, 1, provincia_parinacota),
        (estructura_comuna_id, 'Comuna de General Lagos', NULL, 2, provincia_parinacota);

    -- Insert comunas for Región de Tarapacá
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_comuna_id, 'Comuna de Iquique', NULL, 1, provincia_iquique),
        (estructura_comuna_id, 'Comuna de Alto Hospicio', NULL, 2, provincia_iquique),
        (estructura_comuna_id, 'Comuna de Pozo Almonte', NULL, 1, provincia_tamarugal),
        (estructura_comuna_id, 'Comuna de Camiña', NULL, 2, provincia_tamarugal),
        (estructura_comuna_id, 'Comuna de Colchane', NULL, 3, provincia_tamarugal),
        (estructura_comuna_id, 'Comuna de Huara', NULL, 4, provincia_tamarugal),
        (estructura_comuna_id, 'Comuna de Pica', NULL, 5, provincia_tamarugal);

    -- Insert comunas for Región de Antofagasta
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_comuna_id, 'Comuna de Antofagasta', NULL, 1, provincia_antofagasta),
        (estructura_comuna_id, 'Comuna de Mejillones', NULL, 2, provincia_antofagasta),
        (estructura_comuna_id, 'Comuna de Sierra Gorda', NULL, 3, provincia_antofagasta),
        (estructura_comuna_id, 'Comuna de Taltal', NULL, 4, provincia_antofagasta),
        (estructura_comuna_id, 'Comuna de Calama', NULL, 1, provincia_eloa),
        (estructura_comuna_id, 'Comuna de Ollagüe', NULL, 2, provincia_eloa),
        (estructura_comuna_id, 'Comuna de San Pedro de Atacama', NULL, 3, provincia_eloa),
        (estructura_comuna_id, 'Comuna de Tocopilla', NULL, 1, provincia_tocopilla),
        (estructura_comuna_id, 'Comuna de María Elena', NULL, 2, provincia_tocopilla);

    -- Insert comunas for Región de Atacama
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        (estructura_comuna_id, 'Comuna de Copiapó', NULL, 1, provincia_copiapo),
        (estructura_comuna_id, 'Comuna de Caldera', NULL, 2, provincia_copiapo),
        (estructura_comuna_id, 'Comuna de Tierra Amarilla', NULL, 3, provincia_copiapo),
        (estructura_comuna_id, 'Comuna de Chañaral', NULL, 1, provincia_chañaral),
        (estructura_comuna_id, 'Comuna de Diego de Almagro', NULL, 2, provincia_chañaral),
        (estructura_comuna_id, 'Comuna de Vallenar', NULL, 1, provincia_huasco),
        (estructura_comuna_id, 'Comuna de Alto del Carmen', NULL, 2, provincia_huasco),
        (estructura_comuna_id, 'Comuna de Freirina', NULL, 3, provincia_huasco),
        (estructura_comuna_id, 'Comuna de Huasco', NULL, 4, provincia_huasco);

    -- Insert comunas for Región de Coquimbo
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        -- Provincia de Elqui
        (estructura_comuna_id, 'Comuna de La Serena', NULL, 1, provincia_elqui),
        (estructura_comuna_id, 'Comuna de Coquimbo', NULL, 2, provincia_elqui),
        (estructura_comuna_id, 'Comuna de Andacollo', NULL, 3, provincia_elqui),
        (estructura_comuna_id, 'Comuna de La Higuera', NULL, 4, provincia_elqui),
        (estructura_comuna_id, 'Comuna de Paihuano', NULL, 5, provincia_elqui),
        (estructura_comuna_id, 'Comuna de Vicuña', NULL, 6, provincia_elqui),

        -- Provincia de Choapa
        (estructura_comuna_id, 'Comuna de Illapel', NULL, 1, provincia_choapa),
        (estructura_comuna_id, 'Comuna de Canela', NULL, 2, provincia_choapa),
        (estructura_comuna_id, 'Comuna de Los Vilos', NULL, 3, provincia_choapa),
        (estructura_comuna_id, 'Comuna de Salamanca', NULL, 4, provincia_choapa),

        -- Provincia de Limarí
        (estructura_comuna_id, 'Comuna de Ovalle', NULL, 1, provincia_limari),
        (estructura_comuna_id, 'Comuna de Combarbalá', NULL, 2, provincia_limari),
        (estructura_comuna_id, 'Comuna de Monte Patria', NULL, 3, provincia_limari),
        (estructura_comuna_id, 'Comuna de Punitaqui', NULL, 4, provincia_limari),
        (estructura_comuna_id, 'Comuna de Río Hurtado', NULL, 5, provincia_limari);


    -- Insert comunas for Región de Valparaíso
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        -- Provincia de Valparaíso
        (estructura_comuna_id, 'Comuna de Valparaíso', NULL, 1, provincia_valparaiso),
        (estructura_comuna_id, 'Comuna de Casablanca', NULL, 2, provincia_valparaiso),
        (estructura_comuna_id, 'Comuna de Concón', NULL, 3, provincia_valparaiso),
        (estructura_comuna_id, 'Comuna de Juan Fernández', NULL, 4, provincia_valparaiso),
        (estructura_comuna_id, 'Comuna de Puchuncaví', NULL, 5, provincia_valparaiso),
        (estructura_comuna_id, 'Comuna de Quintero', NULL, 6, provincia_valparaiso),
        (estructura_comuna_id, 'Comuna de Viña del Mar', NULL, 7, provincia_valparaiso),

        -- Provincia de Isla de Pascua
        (estructura_comuna_id, 'Comuna de Isla de Pascua', NULL, 1, provincia_isla_pascua),

        -- Provincia de Los Andes
        (estructura_comuna_id, 'Comuna de Los Andes', NULL, 1, provincia_los_andes),
        (estructura_comuna_id, 'Comuna de Calle Larga', NULL, 2, provincia_los_andes),
        (estructura_comuna_id, 'Comuna de Rinconada', NULL, 3, provincia_los_andes),
        (estructura_comuna_id, 'Comuna de San Esteban', NULL, 4, provincia_los_andes),

        -- Provincia de Petorca
        (estructura_comuna_id, 'Comuna de La Ligua', NULL, 1, provincia_petorca),
        (estructura_comuna_id, 'Comuna de Cabildo', NULL, 2, provincia_petorca),
        (estructura_comuna_id, 'Comuna de Papudo', NULL, 3, provincia_petorca),
        (estructura_comuna_id, 'Comuna de Petorca', NULL, 4, provincia_petorca),
        (estructura_comuna_id, 'Comuna de Zapallar', NULL, 5, provincia_petorca),

        -- Provincia de Quillota
        (estructura_comuna_id, 'Comuna de Quillota', NULL, 1, provincia_quillota),
        (estructura_comuna_id, 'Comuna de La Calera', NULL, 2, provincia_quillota),
        (estructura_comuna_id, 'Comuna de Hijuelas', NULL, 3, provincia_quillota),
        (estructura_comuna_id, 'Comuna de La Cruz', NULL, 4, provincia_quillota),
        (estructura_comuna_id, 'Comuna de Nogales', NULL, 5, provincia_quillota),

        -- Provincia de San Antonio
        (estructura_comuna_id, 'Comuna de San Antonio', NULL, 1, provincia_san_antonio),
        (estructura_comuna_id, 'Comuna de Algarrobo', NULL, 2, provincia_san_antonio),
        (estructura_comuna_id, 'Comuna de Cartagena', NULL, 3, provincia_san_antonio),
        (estructura_comuna_id, 'Comuna de El Quisco', NULL, 4, provincia_san_antonio),
        (estructura_comuna_id, 'Comuna de El Tabo', NULL, 5, provincia_san_antonio),
        (estructura_comuna_id, 'Comuna de Santo Domingo', NULL, 6, provincia_san_antonio),

        -- Provincia de San Felipe de Aconcagua
        (estructura_comuna_id, 'Comuna de San Felipe', NULL, 1, provincia_san_felipe_de_aconcagua),
        (estructura_comuna_id, 'Comuna de Catemu', NULL, 2, provincia_san_felipe_de_aconcagua),
        (estructura_comuna_id, 'Comuna de Llay Llay', NULL, 3, provincia_san_felipe_de_aconcagua),
        (estructura_comuna_id, 'Comuna de Panquehue', NULL, 4, provincia_san_felipe_de_aconcagua),
        (estructura_comuna_id, 'Comuna de Putaendo', NULL, 5, provincia_san_felipe_de_aconcagua),
        (estructura_comuna_id, 'Comuna de Santa María', NULL, 6, provincia_san_felipe_de_aconcagua),

        -- Provincia de Marga Marga
        (estructura_comuna_id, 'Comuna de Quilpué', NULL, 1, provincia_marga_marga),
        (estructura_comuna_id, 'Comuna de Limache', NULL, 2, provincia_marga_marga),
        (estructura_comuna_id, 'Comuna de Olmué', NULL, 3, provincia_marga_marga),
        (estructura_comuna_id, 'Comuna de Villa Alemana', NULL, 4, provincia_marga_marga);



    -- Insert comunas for Región del Libertador General Bernardo O'Higgins
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        -- Provincia de Cachapoal
        (estructura_comuna_id, 'Comuna de Rancagua', NULL, 1, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Codegua', NULL, 2, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Coinco', NULL, 3, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Coltauco', NULL, 4, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Doñihue', NULL, 5, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Graneros', NULL, 6, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Las Cabras', NULL, 7, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Machalí', NULL, 8, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Malloa', NULL, 9, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Mostazal', NULL, 10, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Olivar', NULL, 11, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Peumo', NULL, 12, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Pichidegua', NULL, 13, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Quinta de Tilcoco', NULL, 14, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Rengo', NULL, 15, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de Requínoa', NULL, 16, provincia_cachapoal),
        (estructura_comuna_id, 'Comuna de San Vicente de Tagua Tagua', NULL, 17, provincia_cachapoal),

        -- Provincia Cardenal Caro
        (estructura_comuna_id, 'Comuna de Pichilemu', NULL, 1, provincia_cardenal_caro),
        (estructura_comuna_id, 'Comuna de La Estrella', NULL, 2, provincia_cardenal_caro),
        (estructura_comuna_id, 'Comuna de Litueche', NULL, 3, provincia_cardenal_caro),
        (estructura_comuna_id, 'Comuna de Marchihue', NULL, 4, provincia_cardenal_caro),
        (estructura_comuna_id, 'Comuna de Navidad', NULL, 5, provincia_cardenal_caro),
        (estructura_comuna_id, 'Comuna de Paredones', NULL, 6, provincia_cardenal_caro),

        -- Provincia de Colchagua
        (estructura_comuna_id, 'Comuna de San Fernando', NULL, 1, provincia_colchagua),
        (estructura_comuna_id, 'Comuna de Chépica', NULL, 2, provincia_colchagua),
        (estructura_comuna_id, 'Comuna de Chimbarongo', NULL, 3, provincia_colchagua),
        (estructura_comuna_id, 'Comuna de Lolol', NULL, 4, provincia_colchagua),
        (estructura_comuna_id, 'Comuna de Nancagua', NULL, 5, provincia_colchagua),
        (estructura_comuna_id, 'Comuna de Palmilla', NULL, 6, provincia_colchagua),
        (estructura_comuna_id, 'Comuna de Peralillo', NULL, 7, provincia_colchagua),
        (estructura_comuna_id, 'Comuna de Placilla', NULL, 8, provincia_colchagua),
        (estructura_comuna_id, 'Comuna de Pumanque', NULL, 9, provincia_colchagua),
        (estructura_comuna_id, 'Comuna de Santa Cruz', NULL, 10, provincia_colchagua);


    -- Insert comunas for Región del Maule
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        -- Provincia de Talca
        (estructura_comuna_id, 'Comuna de Talca', NULL, 1, provincia_talca),
        (estructura_comuna_id, 'Comuna de Constitución', NULL, 2, provincia_talca),
        (estructura_comuna_id, 'Comuna de Curepto', NULL, 3, provincia_talca),
        (estructura_comuna_id, 'Comuna de Empedrado', NULL, 4, provincia_talca),
        (estructura_comuna_id, 'Comuna de Maule', NULL, 5, provincia_talca),
        (estructura_comuna_id, 'Comuna de Pelarco', NULL, 6, provincia_talca),
        (estructura_comuna_id, 'Comuna de Pencahue', NULL, 7, provincia_talca),
        (estructura_comuna_id, 'Comuna de Río Claro', NULL, 8, provincia_talca),
        (estructura_comuna_id, 'Comuna de San Clemente', NULL, 9, provincia_talca),
        (estructura_comuna_id, 'Comuna de San Rafael', NULL, 10, provincia_talca),

        -- Provincia de Cauquenes
        (estructura_comuna_id, 'Comuna de Cauquenes', NULL, 1, provincia_cauquenes),
        (estructura_comuna_id, 'Comuna de Chanco', NULL, 2, provincia_cauquenes),
        (estructura_comuna_id, 'Comuna de Pelluhue', NULL, 3, provincia_cauquenes),

        -- Provincia de Curicó
        (estructura_comuna_id, 'Comuna de Curicó', NULL, 1, provincia_curico),
        (estructura_comuna_id, 'Comuna de Hualañé', NULL, 2, provincia_curico),
        (estructura_comuna_id, 'Comuna de Licantén', NULL, 3, provincia_curico),
        (estructura_comuna_id, 'Comuna de Molina', NULL, 4, provincia_curico),
        (estructura_comuna_id, 'Comuna de Rauco', NULL, 5, provincia_curico),
        (estructura_comuna_id, 'Comuna de Romeral', NULL, 6, provincia_curico),
        (estructura_comuna_id, 'Comuna de Sagrada Familia', NULL, 7, provincia_curico),
        (estructura_comuna_id, 'Comuna de Teno', NULL, 8, provincia_curico),
        (estructura_comuna_id, 'Comuna de Vichuquén', NULL, 9, provincia_curico),

        -- Provincia de Linares
        (estructura_comuna_id, 'Comuna de Linares', NULL, 1, provincia_linares),
        (estructura_comuna_id, 'Comuna de Colbún', NULL, 2, provincia_linares),
        (estructura_comuna_id, 'Comuna de Longaví', NULL, 3, provincia_linares),
        (estructura_comuna_id, 'Comuna de Parral', NULL, 4, provincia_linares),
        (estructura_comuna_id, 'Comuna de Retiro', NULL, 5, provincia_linares),
        (estructura_comuna_id, 'Comuna de San Javier', NULL, 6, provincia_linares),
        (estructura_comuna_id, 'Comuna de Villa Alegre', NULL, 7, provincia_linares),
        (estructura_comuna_id, 'Comuna de Yerbas Buenas', NULL, 8, provincia_linares);

    -- Insert comunas for Región de Ñuble
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        -- Provincia de Diguillín
        (estructura_comuna_id, 'Comuna de Chillán', NULL, 1, provincia_diguillin),
        (estructura_comuna_id, 'Comuna de Bulnes', NULL, 2, provincia_diguillin),
        (estructura_comuna_id, 'Comuna de Chillán Viejo', NULL, 3, provincia_diguillin),
        (estructura_comuna_id, 'Comuna de El Carmen', NULL, 4, provincia_diguillin),
        (estructura_comuna_id, 'Comuna de Pemuco', NULL, 5, provincia_diguillin),
        (estructura_comuna_id, 'Comuna de Pinto', NULL, 6, provincia_diguillin),
        (estructura_comuna_id, 'Comuna de Quillón', NULL, 7, provincia_diguillin),
        (estructura_comuna_id, 'Comuna de San Ignacio', NULL, 8, provincia_diguillin),
        (estructura_comuna_id, 'Comuna de Yungay', NULL, 9, provincia_diguillin),

        -- Provincia de Itata
        (estructura_comuna_id, 'Comuna de Quirihue', NULL, 1, provincia_itata),
        (estructura_comuna_id, 'Comuna de Cobquecura', NULL, 2, provincia_itata),
        (estructura_comuna_id, 'Comuna de Coelemu', NULL, 2, provincia_itata),
        (estructura_comuna_id, 'Comuna de Ninhue', NULL, 3, provincia_itata),
        (estructura_comuna_id, 'Comuna de Portezuelo', NULL, 4, provincia_itata),
        (estructura_comuna_id, 'Comuna de Ránquil', NULL, 5, provincia_itata),
        (estructura_comuna_id, 'Comuna de Trehuaco', NULL, 6, provincia_itata),

        -- Provincia de Punilla
        (estructura_comuna_id, 'Comuna de San Carlos', NULL, 1, provincia_punilla),
        (estructura_comuna_id, 'Comuna de Coihueco', NULL, 2, provincia_punilla),
        (estructura_comuna_id, 'Comuna de Ñiquén', NULL, 3, provincia_punilla),
        (estructura_comuna_id, 'Comuna de San Fabián', NULL, 4, provincia_punilla),
        (estructura_comuna_id, 'Comuna de San Nicolás', NULL, 5, provincia_punilla);

    -- Insert comunas for Región del Biobío
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        -- Provincia de Concepción
        (estructura_comuna_id, 'Comuna de Concepción', NULL, 1, provincia_concepcion),
        (estructura_comuna_id, 'Comuna de Coronel', NULL, 2, provincia_concepcion),
        (estructura_comuna_id, 'Comuna de Chiguayante', NULL, 3, provincia_concepcion),
        (estructura_comuna_id, 'Comuna de Florida', NULL, 4, provincia_concepcion),
        (estructura_comuna_id, 'Comuna de Hualqui', NULL, 5, provincia_concepcion),
        (estructura_comuna_id, 'Comuna de Lota', NULL, 6, provincia_concepcion),
        (estructura_comuna_id, 'Comuna de Penco', NULL, 7, provincia_concepcion),
        (estructura_comuna_id, 'Comuna de San Pedro de la Paz', NULL, 8, provincia_concepcion),
        (estructura_comuna_id, 'Comuna de Santa Juana', NULL, 9, provincia_concepcion),
        (estructura_comuna_id, 'Comuna de Talcahuano', NULL, 10, provincia_concepcion),
        (estructura_comuna_id, 'Comuna de Tomé', NULL, 11, provincia_concepcion),
        (estructura_comuna_id, 'Comuna de Hualpén', NULL, 12, provincia_concepcion),

        -- Provincia de Arauco
        (estructura_comuna_id, 'Comuna de Lebu', NULL, 1, provincia_arauco),
        (estructura_comuna_id, 'Comuna de Arauco', NULL, 2, provincia_arauco),
        (estructura_comuna_id, 'Comuna de Cañete', NULL, 3, provincia_arauco),
        (estructura_comuna_id, 'Comuna de Contulmo', NULL, 4, provincia_arauco),
        (estructura_comuna_id, 'Comuna de Curanilahue', NULL, 5, provincia_arauco),
        (estructura_comuna_id, 'Comuna de Los Álamos', NULL, 6, provincia_arauco),
        (estructura_comuna_id, 'Comuna de Tirúa', NULL, 7, provincia_arauco),

        -- Provincia del Biobío
        (estructura_comuna_id, 'Comuna de Los Ángeles', NULL, 1, provincia_bio_bio),
        (estructura_comuna_id, 'Comuna de Antuco', NULL, 2, provincia_bio_bio),
        (estructura_comuna_id, 'Comuna de Cabrero', NULL, 3, provincia_bio_bio),
        (estructura_comuna_id, 'Comuna de Laja', NULL, 4, provincia_bio_bio),
        (estructura_comuna_id, 'Comuna de Mulchén', NULL, 5, provincia_bio_bio),
        (estructura_comuna_id, 'Comuna de Nacimiento', NULL, 6, provincia_bio_bio),
        (estructura_comuna_id, 'Comuna de Negrete', NULL, 7, provincia_bio_bio),
        (estructura_comuna_id, 'Comuna de Quilaco', NULL, 8, provincia_bio_bio),
        (estructura_comuna_id, 'Comuna de Quilleco', NULL, 9, provincia_bio_bio),
        (estructura_comuna_id, 'Comuna de San Rosendo', NULL, 10, provincia_bio_bio),
        (estructura_comuna_id, 'Comuna de Santa Bárbara', NULL, 11, provincia_bio_bio),
        (estructura_comuna_id, 'Comuna de Tucapel', NULL, 12, provincia_bio_bio),
        (estructura_comuna_id, 'Comuna de Yumbel', NULL, 13, provincia_bio_bio),
        (estructura_comuna_id, 'Comuna de Alto Biobío', NULL, 14, provincia_bio_bio);

    -- Insert comunas for Región de La Araucanía
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        -- Provincia de Cautín
        (estructura_comuna_id, 'Comuna de Temuco', NULL, 1, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Carahue', NULL, 2, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Cunco', NULL, 3, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Curarrehue', NULL, 4, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Freire', NULL, 5, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Galvarino', NULL, 6, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Gorbea', NULL, 7, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Lautaro', NULL, 8, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Loncoche', NULL, 9, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Melipeuco', NULL, 10, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Nueva Imperial', NULL, 11, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Padre Las Casas', NULL, 12, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Perquenco', NULL, 13, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Pitrufquén', NULL, 14, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Pucón', NULL, 15, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Saavedra', NULL, 16, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Teodoro Schmidt', NULL, 17, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Toltén', NULL, 18, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Vilcún', NULL, 19, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Villarrica', NULL, 20, provincia_cautin),
        (estructura_comuna_id, 'Comuna de Cholchol', NULL, 21, provincia_cautin),

        -- Provincia de Malleco
        (estructura_comuna_id, 'Comuna de Angol', NULL, 1, provincia_malleco),
        (estructura_comuna_id, 'Comuna de Collipulli', NULL, 2, provincia_malleco),
        (estructura_comuna_id, 'Comuna de Curacautín', NULL, 3, provincia_malleco),
        (estructura_comuna_id, 'Comuna de Ercilla', NULL, 4, provincia_malleco),
        (estructura_comuna_id, 'Comuna de Lonquimay', NULL, 5, provincia_malleco),
        (estructura_comuna_id, 'Comuna de Los Sauces', NULL, 6, provincia_malleco),
        (estructura_comuna_id, 'Comuna de Lumaco', NULL, 7, provincia_malleco),
        (estructura_comuna_id, 'Comuna de Purén', NULL, 8, provincia_malleco),
        (estructura_comuna_id, 'Comuna de Renaico', NULL, 9, provincia_malleco),
        (estructura_comuna_id, 'Comuna de Traiguén', NULL, 10, provincia_malleco),
        (estructura_comuna_id, 'Comuna de Victoria', NULL, 11, provincia_malleco);

    -- Insert comunas for Región de Los Ríos
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        -- Provincia de Valdivia
        (estructura_comuna_id, 'Comuna de Valdivia', NULL, 1, provincia_valdivia),
        (estructura_comuna_id, 'Comuna de Corral', NULL, 2, provincia_valdivia),
        (estructura_comuna_id, 'Comuna de Lanco', NULL, 3, provincia_valdivia),
        (estructura_comuna_id, 'Comuna de Los Lagos', NULL, 4, provincia_valdivia),
        (estructura_comuna_id, 'Comuna de Máfil', NULL, 5, provincia_valdivia),
        (estructura_comuna_id, 'Comuna de Mariquina', NULL, 6, provincia_valdivia),
        (estructura_comuna_id, 'Comuna de Paillaco', NULL, 7, provincia_valdivia),
        (estructura_comuna_id, 'Comuna de Panguipulli', NULL, 8, provincia_valdivia),

        -- Provincia del Ranco
        (estructura_comuna_id, 'Comuna de La Unión', NULL, 1, provincia_ranco),
        (estructura_comuna_id, 'Comuna de Futrono', NULL, 2, provincia_ranco),
        (estructura_comuna_id, 'Comuna de Lago Ranco', NULL, 3, provincia_ranco),
        (estructura_comuna_id, 'Comuna de Río Bueno', NULL, 4, provincia_ranco);

    -- Insert comunas for Región de Los Lagos
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        -- Provincia de Llanquihue
        (estructura_comuna_id, 'Comuna de Puerto Montt', NULL, 1, provincia_llanquihue),
        (estructura_comuna_id, 'Comuna de Calbuco', NULL, 2, provincia_llanquihue),
        (estructura_comuna_id, 'Comuna de Cochamó', NULL, 3, provincia_llanquihue),
        (estructura_comuna_id, 'Comuna de Fresia', NULL, 4, provincia_llanquihue),
        (estructura_comuna_id, 'Comuna de Frutillar', NULL, 5, provincia_llanquihue),
        (estructura_comuna_id, 'Comuna de Los Muermos', NULL, 6, provincia_llanquihue),
        (estructura_comuna_id, 'Comuna de Llanquihue', NULL, 7, provincia_llanquihue),
        (estructura_comuna_id, 'Comuna de Maullín', NULL, 8, provincia_llanquihue),
        (estructura_comuna_id, 'Comuna de Puerto Varas', NULL, 9, provincia_llanquihue),

        -- Provincia de Chiloé
        (estructura_comuna_id, 'Comuna de Castro', NULL, 1, provincia_chiloe),
        (estructura_comuna_id, 'Comuna de Ancud', NULL, 2, provincia_chiloe),
        (estructura_comuna_id, 'Comuna de Chonchi', NULL, 3, provincia_chiloe),
        (estructura_comuna_id, 'Comuna de Curaco de Vélez', NULL, 4, provincia_chiloe),
        (estructura_comuna_id, 'Comuna de Dalcahue', NULL, 5, provincia_chiloe),
        (estructura_comuna_id, 'Comuna de Puqueldón', NULL, 6, provincia_chiloe),
        (estructura_comuna_id, 'Comuna de Queilén', NULL, 7, provincia_chiloe),
        (estructura_comuna_id, 'Comuna de Quellón', NULL, 8, provincia_chiloe),
        (estructura_comuna_id, 'Comuna de Quemchi', NULL, 9, provincia_chiloe),
        (estructura_comuna_id, 'Comuna de Quinchao', NULL, 10, provincia_chiloe),

        -- Provincia de Osorno
        (estructura_comuna_id, 'Comuna de Osorno', NULL, 1, provincia_osorno),
        (estructura_comuna_id, 'Comuna de Puerto Octay', NULL, 2, provincia_osorno),
        (estructura_comuna_id, 'Comuna de Purranque', NULL, 3, provincia_osorno),
        (estructura_comuna_id, 'Comuna de Puyehue', NULL, 4, provincia_osorno),
        (estructura_comuna_id, 'Comuna de Río Negro', NULL, 5, provincia_osorno),
        (estructura_comuna_id, 'Comuna de San Juan de la Costa', NULL, 6, provincia_osorno),
        (estructura_comuna_id, 'Comuna de San Pablo', NULL, 7, provincia_osorno),

        -- Provincia de Palena
        (estructura_comuna_id, 'Comuna de Chaitén', NULL, 1, provincia_palena),
        (estructura_comuna_id, 'Comuna de Futaleufú', NULL, 2, provincia_palena),
        (estructura_comuna_id, 'Comuna de Hualaihué', NULL, 3, provincia_palena),
        (estructura_comuna_id, 'Comuna de Palena', NULL, 4, provincia_palena);

    -- Insert comunas for Región de Aysén del General Carlos Ibáñez del Campo
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        -- Provincia de Coyhaique
        (estructura_comuna_id, 'Comuna de Coyhaique', NULL, 1, provincia_coyhaique),
        (estructura_comuna_id, 'Comuna de Lago Verde', NULL, 2, provincia_coyhaique),

        -- Provincia de Aysén
        (estructura_comuna_id, 'Comuna de Aysén', NULL, 1, provincia_aysen),
        (estructura_comuna_id, 'Comuna de Cisnes', NULL, 2, provincia_aysen),
        (estructura_comuna_id, 'Comuna de Guaitecas', NULL, 3, provincia_aysen),

        -- Provincia de Capitán Prat
        (estructura_comuna_id, 'Comuna de Cochrane', NULL, 1, provincia_capitan_prat),
        (estructura_comuna_id, 'Comuna de O’Higgins', NULL, 2, provincia_capitan_prat),
        (estructura_comuna_id, 'Comuna de Tortel', NULL, 3, provincia_capitan_prat),

        -- Provincia de General Carrera
        (estructura_comuna_id, 'Comuna de Chile Chico', NULL, 1, provincia_gral_carrera),
        (estructura_comuna_id, 'Comuna de Río Ibáñez', NULL, 2, provincia_gral_carrera);

    -- Insert comunas for Región de Magallanes y de la Antártica Chilena
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        -- Provincia de Magallanes
        (estructura_comuna_id, 'Comuna de Punta Arenas', NULL, 1, provincia_magallanes),
        (estructura_comuna_id, 'Comuna de Laguna Blanca', NULL, 2, provincia_magallanes),
        (estructura_comuna_id, 'Comuna de Río Verde', NULL, 3, provincia_magallanes),
        (estructura_comuna_id, 'Comuna de San Gregorio', NULL, 4, provincia_magallanes),

        -- Provincia de Antártica Chilena
        (estructura_comuna_id, 'Comuna de Cabo de Hornos', NULL, 1, provincia_antartica_chilena),
        (estructura_comuna_id, 'Comuna de Antártica', NULL, 2, provincia_antartica_chilena),

        -- Provincia de Tierra del Fuego
        (estructura_comuna_id, 'Comuna de Porvenir', NULL, 1, provincia_tierra_del_fuego),
        (estructura_comuna_id, 'Comuna de Primavera', NULL, 2, provincia_tierra_del_fuego),
        (estructura_comuna_id, 'Comuna de Timaukel', NULL, 3, provincia_tierra_del_fuego),

        -- Provincia de Última Esperanza
        (estructura_comuna_id, 'Comuna de Puerto Natales', NULL, 1, provincia_ultima_esperanza),
        (estructura_comuna_id, 'Comuna de Torres del Paine', NULL, 2, provincia_ultima_esperanza);


-- Insert comunas for Región Metropolitana de Santiago
    INSERT INTO niveles_administrativos (estructura_nivel_id, nombre, numeracion, orden, padre_id)
    VALUES
        -- Provincia de Santiago
        (estructura_comuna_id, 'Comuna de Santiago', NULL, 1, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Cerrillos', NULL, 2, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Cerro Navia', NULL, 3, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Conchalí', NULL, 4, provincia_santiago),
        (estructura_comuna_id, 'Comuna de El Bosque', NULL, 5, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Estación Central', NULL, 6, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Huechuraba', NULL, 7, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Independencia', NULL, 8, provincia_santiago),
        (estructura_comuna_id, 'Comuna de La Cisterna', NULL, 9, provincia_santiago),
        (estructura_comuna_id, 'Comuna de La Florida', NULL, 10, provincia_santiago),
        (estructura_comuna_id, 'Comuna de La Granja', NULL, 11, provincia_santiago),
        (estructura_comuna_id, 'Comuna de La Pintana', NULL, 12, provincia_santiago),
        (estructura_comuna_id, 'Comuna de La Reina', NULL, 13, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Las Condes', NULL, 14, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Lo Barnechea', NULL, 15, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Lo Espejo', NULL, 16, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Lo Prado', NULL, 17, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Macul', NULL, 18, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Maipú', NULL, 19, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Ñuñoa', NULL, 20, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Pedro Aguirre Cerda', NULL, 21, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Peñalolén', NULL, 22, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Providencia', NULL, 23, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Pudahuel', NULL, 24, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Quilicura', NULL, 25, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Quinta Normal', NULL, 26, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Recoleta', NULL, 27, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Renca', NULL, 28, provincia_santiago),
        (estructura_comuna_id, 'Comuna de San Joaquín', NULL, 29, provincia_santiago),
        (estructura_comuna_id, 'Comuna de San Miguel', NULL, 30, provincia_santiago),
        (estructura_comuna_id, 'Comuna de San Ramón', NULL, 31, provincia_santiago),
        (estructura_comuna_id, 'Comuna de Vitacura', NULL, 32, provincia_santiago),

        -- Provincia de Cordillera
        (estructura_comuna_id, 'Comuna de Puente Alto', NULL, 1, provincia_cordillera),
        (estructura_comuna_id, 'Comuna de Pirque', NULL, 2, provincia_cordillera),
        (estructura_comuna_id, 'Comuna de San José de Maipo', NULL, 3, provincia_cordillera),

        -- Provincia de Chacabuco
        (estructura_comuna_id, 'Comuna de Colina', NULL, 1, provincia_chacabuco),
        (estructura_comuna_id, 'Comuna de Lampa', NULL, 2, provincia_chacabuco),
        (estructura_comuna_id, 'Comuna de Tiltil', NULL, 3, provincia_chacabuco),

        -- Provincia de Maipo
        (estructura_comuna_id, 'Comuna de San Bernardo', NULL, 1, provincia_maipo),
        (estructura_comuna_id, 'Comuna de Buin', NULL, 2, provincia_maipo),
        (estructura_comuna_id, 'Comuna de Calera de Tango', NULL, 3, provincia_maipo),
        (estructura_comuna_id, 'Comuna de Paine', NULL, 4, provincia_maipo),

        -- Provincia de Melipilla
        (estructura_comuna_id, 'Comuna de Melipilla', NULL, 1, provincia_melipilla),
        (estructura_comuna_id, 'Comuna de Alhué', NULL, 2, provincia_melipilla),
        (estructura_comuna_id, 'Comuna de Curacaví', NULL, 3, provincia_melipilla),
        (estructura_comuna_id, 'Comuna de María Pinto', NULL, 4, provincia_melipilla),
        (estructura_comuna_id, 'Comuna de San Pedro', NULL, 5, provincia_melipilla),

        -- Provincia de Talagante
        (estructura_comuna_id, 'Comuna de Talagante', NULL, 1, provincia_talagante),
        (estructura_comuna_id, 'Comuna de El Monte', NULL, 2, provincia_talagante),
        (estructura_comuna_id, 'Comuna de Isla de Maipo', NULL, 3, provincia_talagante),
        (estructura_comuna_id, 'Comuna de Padre Hurtado', NULL, 4, provincia_talagante),
        (estructura_comuna_id, 'Comuna de Peñaflor', NULL, 5, provincia_talagante);

END $$;
