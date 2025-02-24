CREATE TABLE staging.tmp_formulario_bienvenida (
    rut VARCHAR(200) PRIMARY KEY,
    telefono VARCHAR(15),
    calle VARCHAR(200),
    numeracion VARCHAR(20),
    comuna VARCHAR(100),
    militancia_previa VARCHAR(2),
    candidatura_previa VARCHAR(2),
    cargo_candidatura_previa VARCHAR(100),
    profesion VARCHAR(200),
    estado_civil VARCHAR(20),
    motivacion VARCHAR(200),
    solo_firma VARCHAR(2),
    quiere_militar VARCHAR(2),
    quiere_coordinar VARCHAR(2),
    quiere_ser_comunicador VARCHAR(2),
    quiere_ser_candidato VARCHAR(2),
    quiere_aportar_con_profesion VARCHAR(2)
);

INSERT INTO staging.tmp_formulario_bienvenida
SELECT
    rut,
    '+569'||RIGHT(REGEXP_REPLACE(telefono, '[^0-9]', '', 'g'),8) AS telefono_limpio,
    calle,
    numeración,
    comuna,
    militancia_previa,
    candidatura_previa,
    cargo_candidatura_previa,
    profesion,
    estado_civil,
    motivacion,
    CASE WHEN roles LIKE '%'||'Simplemente firmé para apoyar, no tengo interés por participar activamente de momento'||'%' THEN 'Si' ELSE 'No' END solo_firma,
    CASE WHEN roles LIKE '%'||'Quiero ser un militante activo del partido, promover sus ideas y participar de sus actividades de camaradería y acción política'||'%' THEN 'Si' ELSE 'No' END quiere_militar,
    CASE WHEN roles LIKE '%'||'Quiero tener un rol de coordinación dentro del partido, organizar actividades y hacerme cargo de un grupo de militantes.'||'%' THEN 'Si' ELSE 'No' END quiere_coordinar,
    CASE WHEN roles LIKE '%'||'Me gustaría ser un comunicador de las ideas del partido, creando contenido para RRSS y tener un rol de cara al público'||'%' THEN 'Si' ELSE 'No' END quiere_ser_comunicador,
    CASE WHEN roles LIKE '%'||'Quiero hacer una carrera política dentro del partido, formarme y trabajar mi imágen para poder ser candidato a cargos electos.'||'%' THEN 'Si' ELSE 'No' END quiere_ser_candidato,
    CASE WHEN roles LIKE '%'||'Me gustaría aportar con mis habilidades profesionales si el partido lo requiere'||'%' THEN 'Si' ELSE 'No' END quiere_aportar_con_profesion
FROM
    staging.var_formulario_bienvenida
ON CONFLICT (rut) DO UPDATE SET comuna = EXCLUDED.comuna, calle = EXCLUDED.calle, numeracion = EXCLUDED.numeracion