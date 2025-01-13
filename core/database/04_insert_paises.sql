-- Insert data for South American countries into the `paises` table
INSERT INTO datawarehouse.paises (nombre, codigo_iso, codigo_telefono, moneda, codigo_iso_moneda, idioma, localizacion)
VALUES
    ('Argentina', 'AR', 54, 'Peso Argentino', 'ARS', 'Español', 'es_AR.UTF-8'),
    ('Bolivia', 'BO', 591, 'Boliviano', 'BOB', 'Español', 'es_BO.UTF-8'),
    ('Brasil', 'BR', 55, 'Real', 'BRL', 'Portugués', 'pt_BR.UTF-8'),
    ('Chile', 'CL', 56, 'Peso Chileno', 'CLP', 'Español', 'es_CL.UTF-8'),
    ('Colombia', 'CO', 57, 'Peso Colombiano', 'COP', 'Español', 'es_CO.UTF-8'),
    ('Ecuador', 'EC', 593, 'Dólar Estadounidense', 'USD', 'Español', 'es_EC.UTF-8'),
    ('Guyana', 'GY', 592, 'Dólar Guyanés', 'GYD', 'Inglés', 'en_GY.UTF-8'),
    ('Paraguay', 'PY', 595, 'Guaraní', 'PYG', 'Español', 'es_PY.UTF-8'),
    ('Perú', 'PE', 51, 'Sol', 'PEN', 'Español', 'es_PE.UTF-8'),
    ('Surinam', 'SR', 597, 'Dólar de Surinam', 'SRD', 'Holandés', 'nl_SR.UTF-8'),
    ('Uruguay', 'UY', 598, 'Peso Uruguayo', 'UYU', 'Español', 'es_UY.UTF-8'),
    ('Venezuela', 'VE', 58, 'Bolívar Soberano', 'VES', 'Español', 'es_VE.UTF-8');

