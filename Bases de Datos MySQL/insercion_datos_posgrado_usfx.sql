use posgrado_usfx_access;

INSERT INTO tipo_persona (nombre) VALUES 
('Estudiante Interno USFX'),
('Docente USFX'),
('Administrativo USFX'),
('Externo'),
('Extranjero'),
('Persona con Discapacidad');

INSERT INTO tipos (nombre) VALUES 
('Diplomado'),
('Especialidad'),
('Maestría'),
('Doctorado'),
('Posdoctorado');



-- ============================================================
-- 1. TABLA: roles (10 registros)
-- ============================================================
INSERT INTO roles (id_rol, nombre_rol, descripcion) VALUES
(1, 'Administrador', 'Acceso total al sistema de posgrado'),
(2, 'Cajero', 'Registro y cobro de transacciones y colegiaturas'),
(3, 'Coordinador Academico', 'Gestion de programas, grupos y contenidos'),
(4, 'Secretaria', 'Inscripciones y atencion a posgraduantes'),
(5, 'Financiero', 'Reportes contables, arqueos y auditorias'),
(6, 'Docente', 'Acceso a listas y seguimiento de programas'),
(7, 'Estudiante', 'Consulta de planes de pago y estado de cuenta'),
(8, 'Sistemas', 'Mantenimiento técnico e infraestructura de red'),
(9, 'Auditor Interno', 'Supervisión de transacciones y procesos contables'),
(10, 'Director Posgrado', 'Aprobación de programas y políticas de descuento');

-- ============================================================
-- 2. TABLA: usuarios (10 registros)
-- ============================================================
INSERT INTO usuarios (id_usuario, nombre, password, id_rol) VALUES
(1, 'admin_posgrado', 'hash_pass_admin_2026', 1),
(2, 'cajero1_usfx', 'hash_pass_caja1_2026', 2),
(3, 'cajero2_usfx', 'hash_pass_caja2_2026', 2),
(4, 'mzarate_coord', 'hash_pass_coord_2026', 3),
(5, 'pflores_sec', 'hash_pass_sec1_2026', 4),
(6, 'lrojas_fin', 'hash_pass_fin_2026', 5),
(7, 'jortiz_auditor', 'hash_pass_audit_2026', 9),
(8, 'dir_posgrado', 'hash_pass_dir_2026', 10),
(9, 'soporte_sys', 'hash_pass_sys_2026', 8),
(10, 'sguerrero_sec', 'hash_pass_sec2_2026', 4);

-- ============================================================
-- 3. TABLA: tipos (5 registros ajustados)
-- ============================================================
INSERT INTO tipos (id_tipo, nombre) VALUES
(1, 'Diplomado'),
(2, 'Especialidad'),
(3, 'Maestría'),
(4, 'Doctorado'),
(5, 'Posdoctorado');

-- ============================================================
-- 4. TABLA: programas (10 registros ajustados a los 5 tipos)
-- ============================================================
INSERT INTO programas (id_programa, id_tipo, nombre) VALUES
(1, 1, 'Diplomado en Educación Superior y Formación por Competencias'),
(2, 1, 'Diplomado en Derecho Constitucional y Procedimientos'),
(3, 2, 'Especialidad en Cirugía General y Laparoscópica'),
(4, 2, 'Especialidad en Redes y Telecomunicaciones Avanzadas'),
(5, 3, 'Maestría en Administración de Empresas (MBA)'),
(6, 3, 'Maestría en Salud Pública y Epidemiología'),
(7, 3, 'Maestría en Ingeniería Estratégica de Software'),
(8, 4, 'Doctorado en Ciencia, Tecnología e Innovación'),
(9, 4, 'Doctorado en Ciencias Jurídicas y Políticas'),
(10, 5, 'Posdoctorado en Investigación Científica Avanzada');

-- ============================================================
-- 5. TABLA: conceptos (10 registros)
-- ============================================================
INSERT INTO conceptos (id_concepto, nombre) VALUES
(1, 'Matrícula de Inscripción'),
(2, 'Colegiatura Total'),
(3, 'Derecho de Titulación y Certificación'),
(4, 'Defensa de Tesis / Monografía'),
(5, 'Certificado de Calificaciones'),
(6, 'Reprogramación de Módulo'),
(7, 'Legalización de Documentos de Posgrado'),
(8, 'Extensión de Plazo de Defensas'),
(9, 'Homologación de Módulos'),
(10, 'Kardex Académico Oficial');

-- ============================================================
-- 6. TABLA: tipo_persona (6 registros ajustados)
-- ============================================================
INSERT INTO tipo_persona (id_tipo_persona, nombre) VALUES
(1, 'Estudiante Interno USFX'),
(2, 'Docente USFX'),
(3, 'Administrativo USFX'),
(4, 'Externo'),
(5, 'Extranjero'),
(6, 'Persona con Discapacidad');

-- ============================================================
-- 7. TABLA: descuentos_tipo_persona (10 registros ajustados a los 6 tipo_persona)
-- ============================================================
INSERT INTO descuentos_tipo_persona (id_descuento, id_tipo_persona, id_concepto, porcentaje_descuento) VALUES
(1, 1, 2, 10.00), -- Estudiante Interno USFX tiene 10% en Colegiatura
(2, 2, 2, 20.00), -- Docente USFX tiene 20% en Colegiatura
(3, 3, 2, 15.00), -- Administrativo USFX tiene 15% en Colegiatura
(4, 6, 2, 50.00), -- Persona con Discapacidad tiene 50% en Colegiatura
(5, 2, 1, 100.00),-- Docente USFX exento de Matrícula
(6, 1, 1, 15.00), -- Estudiante Interno USFX tiene 15% en Matrícula
(7, 6, 1, 50.00), -- Persona con Discapacidad tiene 50% en Matrícula
(8, 3, 1, 20.00), -- Administrativo USFX tiene 20% en Matrícula
(9, 5, 2, 0.00),  -- Extranjero sin descuento en Colegiatura
(10, 4, 2, 0.00); -- Externo sin descuento en Colegiatura

-- ============================================================
-- 8. TABLA: programas_conceptos (10 registros)
-- ============================================================
INSERT INTO programas_conceptos (id_pc, id_programa, id_concepto, monto_base, desglose, cantidad_pagos) VALUES
(1, 1, 1, 500.00, 0, 1),   -- Diplomado Ed. Sup. / Matrícula
(2, 1, 2, 4500.00, 1, 5),  -- Diplomado Ed. Sup. / Colegiatura en 5 cuotas
(3, 2, 1, 600.00, 0, 1),   -- Diplomado Derecho / Matrícula
(4, 2, 2, 5000.00, 1, 5),  -- Diplomado Derecho / Colegiatura en 5 cuotas
(5, 5, 1, 800.00, 0, 1),   -- Maestría MBA / Matrícula
(6, 5, 2, 12000.00, 1, 12),-- Maestría MBA / Colegiatura en 12 cuotas
(7, 7, 1, 800.00, 0, 1),   -- Maestría Software / Matrícula
(8, 7, 2, 14000.00, 1, 14),-- Maestría Software / Colegiatura en 14 cuotas
(9, 8, 1, 1200.00, 0, 1),  -- Doctorado CTI / Matrícula
(10, 8, 2, 24000.00, 1, 24);-- Doctorado CTI / Colegiatura en 24 cuotas

-- ============================================================
-- 9. TABLA: grupos (10 registros)
-- ============================================================
INSERT INTO grupos (id_grupo, id_programa, nombre) VALUES
(1, 1, 'Grupo 01 - Versión XI'),
(2, 1, 'Grupo 02 - Versión XI'),
(3, 2, 'Grupo 01 - Versión V'),
(4, 3, 'Residencia Médica 2026'),
(5, 5, 'Grupo Executive 2026'),
(6, 5, 'Grupo Regular 2026'),
(7, 7, 'Virtual Cohorte I'),
(8, 8, 'Cohorte 2026-2029'),
(9, 9, 'Cohorte Derecho 2026'),
(10, 10, 'Investigación Avanzada G1');

-- ============================================================
-- 10. TABLA: personas (10 registros ajustados a tipo_persona)
-- ============================================================
INSERT INTO personas (id_persona, ci, paterno, materno, nombres, id_tipo_persona) VALUES    
(5, '4312890-PT', 'Siles', 'Navarro', 'Roberto', 3),            -- Administrativo USFX
(6, '9123847-TJ', 'Benítez', 'Soliz', 'Lucía Fernanda', 6),     -- Persona con Discapacidad
(7, '8341920-OR', 'Mamani', 'Quinteros', 'David Pedro', 4),     -- Externo
(8, '7239102-CH', 'Pérez', 'Camargo', 'Mariana', 2),            -- Docente USFX
(9, '6102938-SC', 'Vaca', 'Díez', 'Fernando Luis', 5),          -- Extranjero
(10, '5192834-CH', 'Condori', 'Flores', 'Sonia Patricia', 6);   -- Persona con Discapacidad

-- ============================================================
-- 11. TABLA: personas_programas (10 registros)
-- ============================================================
INSERT INTO personas_programas (id_persona_programa, id_persona, id_programa, id_grupo, fecha_inscripcion, estado) VALUES
(1, 1, 1, 1, '2026-01-10', 'ACTIVA'),
(3, 3, 2, 3, '2026-01-15', 'ACTIVA'),
(4, 4, 5, 5, '2026-02-01', 'ACTIVA'),
(5, 5, 5, 5, '2026-02-02', 'ACTIVA'),
(6, 6, 7, 7, '2026-02-10', 'ACTIVA'),
(7, 7, 7, 7, '2026-02-11', 'ACTIVA'),
(8, 8, 8, 8, '2026-02-15', 'ACTIVA'),
(9, 9, 2, 3, '2026-02-18', 'RETIRADA'),
(10, 10, 1, 2, '2026-02-20', 'ACTIVA');

-- ============================================================
-- 12. TABLA: plan_pagos (10 registros ajustados a los montos y descuentos)
-- ============================================================
INSERT INTO plan_pagos (id_plan, id_persona_programa, id_pc, monto_total, cantidad_cuotas, fecha_inicio, estado) VALUES
(1, 1, 2, 3600.00, 5, '2026-02-01', 'ACTIVO'),   -- Docente USFX (20% desc)
(3, 3, 4, 5000.00, 5, '2026-02-15', 'ACTIVO'),   -- Externo (Sin desc)
(4, 4, 6, 10800.00, 12, '2026-03-01', 'ACTIVO'), -- Estudiante Interno (10% desc)
(5, 5, 6, 10200.00, 12, '2026-03-01', 'ACTIVO'), -- Administrativo USFX (15% desc)
(6, 6, 8, 7000.00, 14, '2026-03-01', 'ACTIVO'),  -- Discapacidad (50% desc)
(7, 7, 8, 14000.00, 14, '2026-03-01', 'ACTIVO'), -- Externo (Sin desc)
(8, 8, 10, 19200.00, 24, '2026-03-15', 'ACTIVO'),-- Docente USFX (20% desc)
(9, 9, 4, 5000.00, 5, '2026-02-15', 'CANCELADO'),-- Retirado
(10, 10, 2, 2250.00, 5, '2026-03-01', 'ACTIVO'); -- Discapacidad (50% desc)

-- ============================================================
-- 13. TABLA: cuotas (10 registros)
-- ============================================================
INSERT INTO cuotas (id_cuota, id_plan, numero_cuota, fecha_vencimiento, monto_cuota, estado_pago) VALUES
(1, 1, 1, '2026-02-15', 720.00, 'PAGADA'),
(2, 1, 2, '2026-03-15', 720.00, 'PAGADA'),
(3, 1, 3, '2026-04-15', 720.00, 'PENDIENTE'),
(6, 3, 1, '2026-03-01', 1000.00, 'PAGADA'),
(7, 3, 2, '2026-04-01', 1000.00, 'PENDIENTE'),
(8, 4, 1, '2026-03-15', 900.00, 'PAGADA'),
(9, 5, 1, '2026-03-15', 850.00, 'PAGADA'),
(10, 6, 1, '2026-03-15', 500.00, 'PAGADA');

-- ============================================================
-- 14. TABLA: transacciones (10 registros)
-- ============================================================
INSERT INTO transacciones (id_transaccion, id_persona_programa, id_usuario, nit_ci, nombre_factura, fecha_emision, fecha_transaccion, monto_total, estado) VALUES
(1, 1, 2, '7548123', 'Carlos Mendoza Vargas', '2026-01-10', '2026-01-10 09:15:00', 0.00, 'REGISTRADA'),    -- Exento Matrícula Docente
(2, 1, 2, '7548123', 'Carlos Mendoza Vargas', '2026-02-12', '2026-02-12 10:30:00', 720.00, 'REGISTRADA'),  -- Cuota 1
(3, 1, 3, '7548123', 'Carlos Mendoza Vargas', '2026-03-10', '2026-03-10 11:45:00', 720.00, 'REGISTRADA'),  -- Cuota 2
(6, 3, 3, '6423189', 'Juan José Gutiérrez', '2026-01-15', '2026-01-15 08:30:00', 600.00, 'REGISTRADA'),    -- Matrícula
(7, 3, 3, '6423189', 'Juan José Gutiérrez', '2026-02-28', '2026-02-28 15:10:00', 1000.00, 'REGISTRADA'),   -- Cuota 1
(8, 4, 2, '5891234', 'Elena Sofía Alvarez', '2026-02-01', '2026-02-01 11:00:00', 680.00, 'REGISTRADA'),    -- Matrícula desc. Estudiante
(9, 4, 2, '5891234', 'Elena Sofía Alvarez', '2026-03-12', '2026-03-12 09:50:00', 900.00, 'REGISTRADA'),    -- Cuota 1
(10, 6, 3, '9123847', 'Lucía Fernanda Benítez', '2026-03-14', '2026-03-14 17:30:00', 500.00, 'REGISTRADA'); -- Cuota 1 Discapacidad

-- ============================================================
-- 15. TABLA: detalle_transaccion (10 registros)
-- ============================================================
INSERT INTO detalle_transaccion (id_detalle, id_transaccion, id_concepto, id_cuota, detalle_concepto, cantidad, precio_unit, subtotal) VALUES
(1, 1, 1, NULL, 'Matrícula de Inscripción - Diplomado Ed. Superior (100% Beca Docente)', 1.00, 0.00, 0.00),
(2, 2, 2, 1, 'Colegiatura Cuota 1/5 - Diplomado Ed. Superior', 1.00, 720.00, 720.00),
(3, 3, 2, 2, 'Colegiatura Cuota 2/5 - Diplomado Ed. Superior', 1.00, 720.00, 720.00),
(6, 6, 1, NULL, 'Matrícula de Inscripción - Diplomado Derecho', 1.00, 600.00, 600.00),
(7, 7, 2, 6, 'Colegiatura Cuota 1/5 - Diplomado Derecho', 1.00, 1000.00, 1000.00),
(8, 8, 1, NULL, 'Matrícula de Inscripción con desc. Estudiante Interno - MBA', 1.00, 680.00, 680.00),
(9, 9, 2, 8, 'Colegiatura Cuota 1/12 - Maestría MBA', 1.00, 900.00, 900.00),
(10, 10, 2, 10, 'Colegiatura Cuota 1/14 - Maestría Software (Desc. Discapacidad)', 1.00, 500.00, 500.00);