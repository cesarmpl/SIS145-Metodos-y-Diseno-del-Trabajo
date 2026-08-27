USE postgrado_usfx;

-- 1. ROLES Y USUARIOS
INSERT INTO roles (nombre_rol, descripcion) VALUES
('Administrador', 'Acceso completo al sistema'),
('Cajero', 'Registro de pagos y transacciones'),
('Consulta', 'Solo consulta de información');

INSERT INTO usuarios (nombre, password, id_rol) VALUES
('admin', SHA2('Admin123!', 256), 1),
('cajero', SHA2('Cajero123!', 256), 2),
('consulta', SHA2('Consulta123!', 256), 3);

-- 2. TIPOS DE PROGRAMA Y PROGRAMAS
INSERT INTO tipos (nombre) VALUES
('Diplomado'),
('Especialidad'),
('Maestría');

INSERT INTO programas (id_tipo, nombre) VALUES
(1, 'Ciencia de Datos'),       -- id_programa = 1
(2, 'Software Libre'),          -- id_programa = 2
(3, 'Inteligencia Artificial'); -- id_programa = 3

-- 3. CONCEPTOS Y TIPOS DE PERSONA
INSERT INTO conceptos (nombre) VALUES
('Matrícula'),                   -- id_concepto = 1
('Colegiatura'),                 -- id_concepto = 2
('Tutoría'),                    -- id_concepto = 3
('Publicación');                  -- id_concepto = 4

INSERT INTO tipo_persona (nombre) VALUES
('Externo'),                    -- id_tipo_persona = 1
('USFX'),                       -- id_tipo_persona = 2
('Docente'),                    -- id_tipo_persona = 3
('Administrativo'),             -- id_tipo_persona = 4
('Extranjero'),                 -- id_tipo_persona = 5
('Persona con discapacidad');   -- id_tipo_persona = 6

-- 4. DESCUENTOS
INSERT INTO descuentos_tipo_persona (id_tipo_persona, id_concepto, porcentaje_descuento) VALUES
(2, 2, 20.00), -- USFX + Colegiatura = 20%
(1, 2, 10.00), -- Externo + Colegiatura = 10%
(6, 2, 50.00); -- Discapacidad + Colegiatura = 50%

-- 5. PRESUPUESTO (PROGRAMAS_CONCEPTOS)
INSERT INTO programas_conceptos (id_programa, id_concepto, monto_base, desglose, cantidad_pagos) VALUES
(1, 1, 500.00, FALSE, 1),   -- id_pc = 1
(1, 2, 3000.00, TRUE, 5),   -- id_pc = 2
(1, 3, 500.00, TRUE, 2),    -- id_pc = 3
(2, 1, 1000.00, FALSE, 1),  -- id_pc = 4
(2, 2, 8000.00, TRUE, 8),   -- id_pc = 5
(2, 3, 1000.00, TRUE, 2),   -- id_pc = 6
(3, 1, 1500.00, FALSE, 1),  -- id_pc = 7
(3, 2, 10000.00, TRUE, 10), -- id_pc = 8
(3, 3, 1500.00, TRUE, 2),   -- id_pc = 9
(3, 4, 2000.00, FALSE, 1);  -- id_pc = 10

-- 6. GRUPOS
INSERT INTO grupos (id_programa, nombre) VALUES
(1, 'Grupo A'), -- id_grupo = 1 (Ciencia de Datos)
(1, 'Grupo B'), -- id_grupo = 2 (Ciencia de Datos)
(2, 'Grupo A'), -- id_grupo = 3 (Software Libre)
(3, 'Grupo A'); -- id_grupo = 4 (IA)

-- 7. PERSONAS
INSERT INTO personas (ci, paterno, materno, nombres, id_tipo_persona) VALUES
('1234567', 'Perez', 'Lopez', 'Juan Carlos', 1),   -- id_persona = 1
('2345678', 'Mamani', 'Quispe', 'Maria Elena', 2),  -- id_persona = 2
('3456789', 'Gomez', 'Rojas', 'Pedro Luis', 6),    -- id_persona = 3
('4567890', 'Fernandez', 'Vargas', 'Ana Lucia', 5); -- id_persona = 4

-- 8. INSCRIPCIONES (personas_programas)
-- CORREGIDO: Se retiró id_programa
INSERT INTO personas_programas (id_persona, id_grupo, fecha_inscripcion, estado) VALUES
(1, 1, '2026-08-25', 'ACTIVA'), -- id_persona_programa = 1 (Juan Carlos -> Grupo A Ciencia de Datos)
(2, 1, '2026-08-25', 'ACTIVA'), -- id_persona_programa = 2 (Maria Elena -> Grupo A Ciencia de Datos)
(3, 2, '2026-08-25', 'ACTIVA'), -- id_persona_programa = 3 (Pedro Luis -> Grupo B Ciencia de Datos)
(4, 4, '2026-08-25', 'ACTIVA'); -- id_persona_programa = 4 (Ana Lucia -> Grupo A IA)

-- 9. PLAN DE PAGOS Y CUOTAS (María Elena - USFX tiene 20% desc en Colegiatura 3000 -> 2400 Bs)
INSERT INTO plan_pagos (id_persona_programa, id_pc, monto_total, cantidad_cuotas, fecha_inicio, estado) VALUES
(2, 2, 2400.00, 5, '2026-09-01', 'ACTIVO'); -- id_plan = 1

INSERT INTO cuotas (id_plan, numero_cuota, fecha_vencimiento, monto_cuota, estado_pago) VALUES
(1, 1, '2026-09-01', 480.00, 'PENDIENTE'), -- id_cuota = 1
(1, 2, '2026-10-01', 480.00, 'PENDIENTE'), -- id_cuota = 2
(1, 3, '2026-11-01', 480.00, 'PENDIENTE'), -- id_cuota = 3
(1, 4, '2026-12-01', 480.00, 'PENDIENTE'), -- id_cuota = 4
(1, 5, '2027-01-01', 480.00, 'PENDIENTE'); -- id_cuota = 5

-- 10. TRANSACCIONES Y DETALLES

-- Transacción 1: María Elena paga Cuota 1
INSERT INTO transacciones (id_persona_programa, id_usuario, nit_ci, nombre_factura, fecha_emision, fecha_transaccion, monto_total, estado) VALUES
(2, 2, '2345678', 'Maria Elena Mamani', '2026-09-01', '2026-09-01 10:30:00', 480.00, 'REGISTRADA'); -- id_transaccion = 1

INSERT INTO detalle_transaccion (id_transaccion, id_concepto, id_cuota, detalle_concepto, cantidad, precio_unit, subtotal) VALUES
(1, 2, 1, 'Colegiatura - Cuota 1', 1, 480.00, 480.00);

UPDATE cuotas SET estado_pago = 'PAGADA' WHERE id_cuota = 1;

-- Transacción 2: Juan Carlos paga Matrícula (Pago directo)
INSERT INTO transacciones (id_persona_programa, id_usuario, nit_ci, nombre_factura, fecha_emision, fecha_transaccion, monto_total, estado) VALUES
(1, 2, '1234567', 'Juan Carlos Perez', '2026-08-25', '2026-08-25 09:30:00', 500.00, 'REGISTRADA'); -- id_transaccion = 2

INSERT INTO detalle_transaccion (id_transaccion, id_concepto, id_cuota, detalle_concepto, cantidad, precio_unit, subtotal) VALUES
(2, 1, NULL, 'Matrícula - Ciencia de Datos', 1, 500.00, 500.00);

-- Transacción 3: María Elena paga Cuota 2
INSERT INTO transacciones (id_persona_programa, id_usuario, nit_ci, nombre_factura, fecha_emision, fecha_transaccion, monto_total, estado) VALUES
(2, 2, '2345678', 'Maria Elena Mamani', '2026-10-01', '2026-10-01 11:15:00', 480.00, 'REGISTRADA'); -- id_transaccion = 3

INSERT INTO detalle_transaccion (id_transaccion, id_concepto, id_cuota, detalle_concepto, cantidad, precio_unit, subtotal) VALUES
(3, 2, 2, 'Colegiatura - Cuota 2', 1, 480.00, 480.00);

UPDATE cuotas SET estado_pago = 'PAGADA' WHERE id_cuota = 2;

-- Transacción 4: María Elena paga Cuotas 3 y 4 juntas
INSERT INTO transacciones (id_persona_programa, id_usuario, nit_ci, nombre_factura, fecha_emision, fecha_transaccion, monto_total, estado) VALUES
(2, 2, '2345678', 'Maria Elena Mamani', '2026-11-03', '2026-11-03 16:20:00', 960.00, 'REGISTRADA'); -- id_transaccion = 4

INSERT INTO detalle_transaccion (id_transaccion, id_concepto, id_cuota, detalle_concepto, cantidad, precio_unit, subtotal) VALUES
(4, 2, 3, 'Colegiatura - Cuota 3', 1, 480.00, 480.00),
(4, 2, 4, 'Colegiatura - Cuota 4', 1, 480.00, 480.00);

UPDATE cuotas SET estado_pago = 'PAGADA' WHERE id_cuota IN (3, 4);