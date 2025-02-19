-- Drop statements
DROP TABLE IF EXISTS var_padron_servel;


-- Create statements
CREATE TABLE IF NOT EXISTS
    var_padron_servel
(
    REGION varchar(255),
    DISTRITO varchar(255),
    COMUNA varchar(255),
    RUN varchar(255),
    DV varchar(255),
    SEXO varchar(255),
    NOMBRES varchar(255),
    APELLIDO_PATERNO varchar(255),
    NOMBRE_COMPLETO varchar(255),
    FECHA_AFILIACION varchar(255),
    FECHA_NACIMIENTO varchar(255),
    DOMICILIO varchar(255),
    EDAD varchar(255),
    CORREO varchar(255),
    REGION_1 varchar(255),
    ID_ARCHIVO varchar(255),
    FECHA_PROCESO varchar(255)
)
    PARTITION BY LIST (ID_ARCHIVO);
