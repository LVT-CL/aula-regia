-- Insertar organización inicial
INSERT INTO organizaciones (nombre, descripcion, fecha_creacion, fecha_actualizacion)
VALUES ('Partido Nacional Libertario', 'Partido político Chileno de ideología soberanista y libertaria', '2024-06-11', CURRENT_TIMESTAMP);

-- Insertar cargos iniciales para la organización
INSERT INTO cargos (organizacion_id, nombre, descripcion, fecha_inicio, fecha_fin)
VALUES
(1, 'Militante', 'Miembro regular del partido', '2024-06-11', NULL),
(1, 'Militante Fundador', 'Miembro fundador del partido', '2024-06-11', NULL),
(1, 'Coordinador Comunal', 'Responsable de la coordinación comunal', '2024-06-11', NULL),
(1, 'Coordinador Distrital', 'Responsable de la coordinación distrital', '2024-06-11', NULL),
(1, 'Coordinador Regional', 'Responsable de la coordinación regional', '2024-06-11', NULL),
(1, 'Directiva Nacional', 'Miembro de la directiva nacional del partido', '2024-06-11', NULL);
