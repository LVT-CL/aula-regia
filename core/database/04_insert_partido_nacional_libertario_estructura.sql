-- Insertar organización inicial
INSERT INTO organizaciones (nombre, descripcion, fecha_creacion, fecha_actualizacion)
VALUES ('Partido Nacional Libertario', 'Partido político fundado en 2024', '2024-06-11', CURRENT_TIMESTAMP);

-- Insertar cargos iniciales para la organización
INSERT INTO cargos (organizacion_id, nombre, descripcion, fecha_inicio, fecha_fin)
VALUES
(1, 'Militante', 'Miembro regular del partido', '2024-06-11', NULL),
(1, 'Militante Fundador', 'Miembro fundador del partido', '2024-06-11', NULL),
(1, 'Coordinador Comunal', 'Responsable de la coordinación comunal', '2024-06-11', NULL),
(1, 'Coordinador Distrital', 'Responsable de la coordinación distrital', '2024-06-11', NULL),
(1, 'Coordinador Regional', 'Responsable de la coordinación regional', '2024-06-11', NULL),
(1, 'Directiva Regional', 'Miembro de la directiva regional del partido', '2024-06-11', NULL),
(1, 'Consejo Regional', 'Miembro del consejo regional del partido', '2024-06-11', NULL),
(1, 'Directiva Nacional', 'Miembro de la directiva nacional del partido', '2024-06-11', NULL),
(1, 'Consejo Nacional', 'Miembro del consejo nacional del partido', '2024-06-11', NULL),
(1, 'Comisión Política', 'Miembro de la comisión política del partido', '2024-06-11', NULL),
(1, 'Tribunal Regional', 'Miembro del tribunal regional del partido', '2024-06-11', NULL),
(1, 'Tribunal Supremo', 'Miembro del tribunal supremo del partido', '2024-06-11', NULL),
(1, 'Autoridad Electa', 'Miembro electo con representación política', '2024-06-11', NULL),
(1, 'Auditor Externo', 'Responsable de auditorías externas', '2024-06-11', NULL);
