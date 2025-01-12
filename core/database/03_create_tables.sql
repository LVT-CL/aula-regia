
-- Eliminar tablas si existen (para recrear el modelo desde cero)
DROP TABLE IF EXISTS persona_direcciones CASCADE;
DROP TABLE IF EXISTS tipos_uso_direccion CASCADE;
DROP TABLE IF EXISTS direcciones CASCADE;
DROP TABLE IF EXISTS unidades_administrativas CASCADE;
DROP TABLE IF EXISTS niveles_administrativos CASCADE;
DROP TABLE IF EXISTS paises CASCADE;
DROP TABLE IF EXISTS designaciones CASCADE;
DROP TABLE IF EXISTS afiliaciones CASCADE;
DROP TABLE IF EXISTS cargos CASCADE;
DROP TABLE IF EXISTS organizaciones CASCADE;
DROP TABLE IF EXISTS correos CASCADE;
DROP TABLE IF EXISTS telefonos CASCADE;
DROP TABLE IF EXISTS personas CASCADE;

-- Crear tabla de Países
CREATE TABLE paises (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    codigo_iso VARCHAR(10) UNIQUE NOT NULL
);

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

-- Crear tabla de Niveles Administrativos
CREATE TABLE niveles_administrativos (
    id SERIAL PRIMARY KEY,
    pais_id INT NOT NULL REFERENCES paises(id) ON DELETE CASCADE,
    nombre VARCHAR(255) NOT NULL,
    nivel_jerarquico INT NOT NULL,
    UNIQUE (pais_id, nivel_jerarquico)
);

-- Crear tabla de Unidades Administrativas
CREATE TABLE unidades_administrativas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    nivel_id INT NOT NULL REFERENCES niveles_administrativos(id) ON DELETE CASCADE,
    unidad_superior_id INT REFERENCES unidades_administrativas(id) ON DELETE CASCADE,
    UNIQUE (nombre, nivel_id)
);

-- Crear tabla de Direcciones
CREATE TABLE direcciones (
    id SERIAL PRIMARY KEY,
    unidad_id INT NOT NULL REFERENCES unidades_administrativas(id) ON DELETE CASCADE,
    calle VARCHAR(255) NOT NULL,
    numero VARCHAR(20),
    bloque VARCHAR(50),
    departamento VARCHAR(50),
    latitud DECIMAL(10, 8),
    longitud DECIMAL(11, 8),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla para Tipos de Uso de Dirección
CREATE TABLE tipos_uso_direccion (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    descripcion TEXT
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

-- Crear índice parcial para garantizar una única afiliación principal por persona y organización
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

-- Crear tabla para asociar Personas y Direcciones
CREATE TABLE persona_direcciones (
    id SERIAL PRIMARY KEY,
    persona_id INT NOT NULL REFERENCES personas(id) ON DELETE CASCADE,
    direccion_id INT NOT NULL REFERENCES direcciones(id) ON DELETE CASCADE,
    tipo_uso_id INT NOT NULL REFERENCES tipos_uso_direccion(id),
    es_principal BOOLEAN DEFAULT FALSE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE
);

-- Crear índice parcial para garantizar una única dirección principal por tipo de uso por persona
CREATE UNIQUE INDEX unico_direccion_principal_por_uso ON persona_direcciones (persona_id, tipo_uso_id)
WHERE es_principal = TRUE;
