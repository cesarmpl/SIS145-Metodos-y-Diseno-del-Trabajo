DROP DATABASE IF EXISTS postgrado_usfx;

CREATE DATABASE postgrado_usfx
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE postgrado_usfx;

CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
);

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    id_rol INT NOT NULL,

    CONSTRAINT fk_usuario_rol
        FOREIGN KEY (id_rol)
        REFERENCES roles(id_rol)
);


-- TIPOS DE POSTGRADO (Diplomado, Especialidad, Maestría)
CREATE TABLE tipos (
    id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE programas (
    id_programa INT AUTO_INCREMENT PRIMARY KEY,
    id_tipo INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,

    CONSTRAINT fk_programa_tipo
        FOREIGN KEY (id_tipo)
        REFERENCES tipos(id_tipo),

    CONSTRAINT uq_programa_tipo_nombre
        UNIQUE (id_tipo, nombre)
);

-- Conceptos: Matrícula, Colegiatura, Tutoría, Publicación
CREATE TABLE conceptos (
    id_concepto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);


-- Tipo de Persona: Externo, USFX, Docente, Administrativo, Extranjero, Persona con discapacidad

CREATE TABLE tipo_persona (
    id_tipo_persona INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- Descuentos: USFX + Colegiatura = 20%, USFX + Tutoría     = 10% Ejm Discapacidad + Colegiatura = 50%
CREATE TABLE descuentos_tipo_persona (
    id_descuento INT AUTO_INCREMENT PRIMARY KEY,
    id_tipo_persona INT NOT NULL,
    id_concepto INT NOT NULL,
    porcentaje_descuento DECIMAL(5,2) NOT NULL,

    CONSTRAINT fk_descuento_tipo_persona
        FOREIGN KEY (id_tipo_persona)
        REFERENCES tipo_persona(id_tipo_persona),

    CONSTRAINT fk_descuento_concepto
        FOREIGN KEY (id_concepto)
        REFERENCES conceptos(id_concepto),

    CONSTRAINT chk_porcentaje_descuento
        CHECK (porcentaje_descuento >= 0
               AND porcentaje_descuento <= 100),

    CONSTRAINT uq_descuento_tipo_concepto
        UNIQUE (id_tipo_persona, id_concepto)
);

-- Esta es nuestra tabla de presupuesto
-- Por ejemplo: Ciencia de Datos: Matrícula  500, Colegiatura    3000, Tutoría   500

CREATE TABLE programas_conceptos (
    id_pc INT AUTO_INCREMENT PRIMARY KEY,
    id_programa INT NOT NULL,
    id_concepto INT NOT NULL,
    monto_base DECIMAL(10,2) NOT NULL,
    desglose BOOLEAN NOT NULL DEFAULT FALSE,
    cantidad_pagos INT NOT NULL DEFAULT 1,

    CONSTRAINT fk_pc_programa
        FOREIGN KEY (id_programa)
        REFERENCES programas(id_programa),

    CONSTRAINT fk_pc_concepto
        FOREIGN KEY (id_concepto)
        REFERENCES conceptos(id_concepto),

    CONSTRAINT chk_monto_base
        CHECK (monto_base >= 0),

    CONSTRAINT chk_cantidad_pagos
        CHECK (cantidad_pagos >= 1),

    CONSTRAINT uq_programa_concepto
        UNIQUE (id_programa, id_concepto)
);


CREATE TABLE grupos (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
    id_programa INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,

    CONSTRAINT fk_grupo_programa
        FOREIGN KEY (id_programa)
        REFERENCES programas(id_programa),

    CONSTRAINT uq_grupo_programa
        UNIQUE (id_programa, nombre)
);

CREATE TABLE personas (
    id_persona INT AUTO_INCREMENT PRIMARY KEY,
    ci VARCHAR(20) NOT NULL UNIQUE,
    paterno VARCHAR(80),
    materno VARCHAR(80),
    nombres VARCHAR(100) NOT NULL,
    id_tipo_persona INT NOT NULL,

    CONSTRAINT fk_persona_tipo
        FOREIGN KEY (id_tipo_persona)
        REFERENCES tipo_persona(id_tipo_persona)
);

-- Esta es la inscripción:
CREATE TABLE personas_programas (
    id_persona_programa INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT NOT NULL,
    id_grupo INT NOT NULL,
    fecha_inscripcion DATE NOT NULL,
    estado ENUM('ACTIVA', 'RETIRADA', 'FINALIZADA')
           NOT NULL DEFAULT 'ACTIVA',

    CONSTRAINT fk_pp_persona
        FOREIGN KEY (id_persona)
        REFERENCES personas(id_persona),

    CONSTRAINT fk_pp_programa
        FOREIGN KEY (id_programa)
        REFERENCES programas(id_programa),

    CONSTRAINT fk_pp_grupo
        FOREIGN KEY (id_grupo)
        REFERENCES grupos(id_grupo)
);


CREATE TABLE plan_pagos (
    id_plan INT AUTO_INCREMENT PRIMARY KEY,
    id_persona_programa INT NOT NULL,
    id_pc INT NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL,
    cantidad_cuotas INT NOT NULL DEFAULT 1,
    fecha_inicio DATE NOT NULL,
    estado ENUM('ACTIVO', 'FINALIZADO', 'CANCELADO')
           NOT NULL DEFAULT 'ACTIVO',

    CONSTRAINT fk_plan_persona_programa
        FOREIGN KEY (id_persona_programa)
        REFERENCES personas_programas(id_persona_programa),

    CONSTRAINT fk_plan_programa_concepto
        FOREIGN KEY (id_pc)
        REFERENCES programas_conceptos(id_pc),

    CONSTRAINT chk_plan_monto
        CHECK (monto_total >= 0),

    CONSTRAINT chk_plan_cuotas
        CHECK (cantidad_cuotas >= 1)
        -- Evita duplicar el plan del mismo concepto para el mismo alumno
    CONSTRAINT uq_plan_persona_pc
        UNIQUE (id_persona_programa, id_pc)
);



CREATE TABLE cuotas (
    id_cuota INT AUTO_INCREMENT PRIMARY KEY,
    id_plan INT NOT NULL,
    numero_cuota INT NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    monto_cuota DECIMAL(10,2) NOT NULL,
    estado_pago ENUM('PENDIENTE', 'PAGADA', 'VENCIDA', 'ANULADA')
                NOT NULL DEFAULT 'PENDIENTE',

    CONSTRAINT fk_cuota_plan
        FOREIGN KEY (id_plan)
        REFERENCES plan_pagos(id_plan),

    CONSTRAINT chk_numero_cuota
        CHECK (numero_cuota >= 1),

    CONSTRAINT chk_monto_cuota
        CHECK (monto_cuota >= 0),

    CONSTRAINT uq_plan_numero_cuota
        UNIQUE (id_plan, numero_cuota)
);

CREATE TABLE transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_persona_programa INT NOT NULL,
    id_usuario INT NOT NULL,
    nit_ci VARCHAR(30),
    nombre_factura VARCHAR(150),
    fecha_emision DATE NOT NULL,
    fecha_transaccion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    monto_total DECIMAL(10,2) NOT NULL,
    estado ENUM('REGISTRADA', 'ANULADA')
            NOT NULL DEFAULT 'REGISTRADA',

    CONSTRAINT fk_transaccion_persona_programa
        FOREIGN KEY (id_persona_programa)
        REFERENCES personas_programas(id_persona_programa),

    CONSTRAINT fk_transaccion_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),

    CONSTRAINT chk_transaccion_monto
        CHECK (monto_total >= 0)
);

CREATE TABLE detalle_transaccion (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_transaccion INT NOT NULL,
    id_concepto INT NOT NULL,
    id_cuota INT NULL,
    detalle_concepto VARCHAR(200),
    cantidad INT NOT NULL DEFAULT 1,
    precio_unit DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_detalle_transaccion
        FOREIGN KEY (id_transaccion)
        REFERENCES transacciones(id_transaccion) 
        ON DELETE CASCADE,

    CONSTRAINT fk_detalle_concepto
        FOREIGN KEY (id_concepto)
        REFERENCES conceptos(id_concepto),

    CONSTRAINT fk_detalle_cuota
        FOREIGN KEY (id_cuota)
        REFERENCES cuotas(id_cuota),

    CONSTRAINT chk_detalle_cantidad
        CHECK (cantidad > 0),

    CONSTRAINT chk_detalle_precio
        CHECK (precio_unit >= 0),

    CONSTRAINT chk_detalle_subtotal
        CHECK (subtotal >= 0)
);
