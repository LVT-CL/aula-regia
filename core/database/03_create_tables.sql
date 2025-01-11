
-- Eliminar tablas si existen (para recrear el modelo desde cero)
DROP TABLE IF EXISTS designaciones CASCADE;
DROP TABLE IF EXISTS afiliaciones CASCADE;
DROP TABLE IF EXISTS cargos CASCADE;
DROP TABLE IF EXISTS organizaciones CASCADE;
DROP TABLE IF EXISTS direcciones CASCADE;
DROP TABLE IF EXISTS correos CASCADE;
DROP TABLE IF EXISTS telefonos CASCADE;
DROP TABLE IF EXISTS personas CASCADE;

-- Crear tabla principal de Personas
CREATE TABLE personas (
    id SERIAL PRIMARY KEY,
    nombres VARCHAR(255) NOT NULL,
    apellido_paterno VARCHAR(255) NOT NULL,
    apellido_materno VARCHAR(255) NOT NULL,
    rut VARCHAR(15) UNIQUE NOT NULL,
    sexo VARCHAR(20),
    fecha_nacimiento DATE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla para Teléfonos
CREATE TABLE telefonos (
    id SERIAL PRIMARY KEY,
    persona_id INT NOT NULL REFERENCES personas(id) ON DELETE CASCADE,
    telefono VARCHAR(20) NOT NULL,
    es_principal BOOLEAN DEFAULT FALSE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE
);

-- Crear índice parcial para garantizar un único teléfono principal por persona
CREATE UNIQUE INDEX unico_telefono_principal ON telefonos (persona_id)
WHERE es_principal = TRUE;

-- Crear tabla para Correos Electrónicos
CREATE TABLE correos (
    id SERIAL PRIMARY KEY,
    persona_id INT NOT NULL REFERENCES personas(id) ON DELETE CASCADE,
    correo VARCHAR(255) NOT NULL,
    es_principal BOOLEAN DEFAULT FALSE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE
);

-- Crear índice parcial para garantizar un único correo principal por persona
CREATE UNIQUE INDEX unico_correo_principal ON correos (persona_id)
WHERE es_principal = TRUE;

-- Crear tabla para Direcciones
CREATE TABLE direcciones (
    id SERIAL PRIMARY KEY,
    persona_id INT NOT NULL REFERENCES personas(id) ON DELETE CASCADE,
    comuna VARCHAR(100) NOT NULL,
    direccion_completa TEXT,
    es_principal BOOLEAN DEFAULT FALSE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE
);

-- Crear índice parcial para garantizar una única dirección principal por persona
CREATE UNIQUE INDEX unico_direccion_principal ON direcciones (persona_id)
WHERE es_principal = TRUE;

-- Crear tabla para Organizaciones
CREATE TABLE organizaciones (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla para Cargos
CREATE TABLE cargos (
    id SERIAL PRIMARY KEY,
    organizacion_id INT NOT NULL REFERENCES organizaciones(id) ON DELETE CASCADE,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE
);

-- Crear tabla para Afiliaciones
CREATE TABLE afiliaciones (
    id SERIAL PRIMARY KEY,
    persona_id INT NOT NULL REFERENCES personas(id) ON DELETE CASCADE,
    organizacion_id INT NOT NULL REFERENCES organizaciones(id) ON DELETE CASCADE,
    fecha_inicio_afiliacion DATE NOT NULL,
    fecha_fin_afiliacion DATE,
    es_principal BOOLEAN DEFAULT TRUE
);

-- Crear índice parcial para garantizar una única afiliación activa por persona y organización
CREATE UNIQUE INDEX unico_afiliacion_principal ON afiliaciones (persona_id, organizacion_id)
WHERE es_principal = TRUE;

-- Crear tabla para Designaciones
CREATE TABLE designaciones (
    id SERIAL PRIMARY KEY,
    afiliacion_id INT NOT NULL REFERENCES afiliaciones(id) ON DELETE CASCADE,
    cargo_id INT NOT NULL REFERENCES cargos(id) ON DELETE CASCADE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE
);
