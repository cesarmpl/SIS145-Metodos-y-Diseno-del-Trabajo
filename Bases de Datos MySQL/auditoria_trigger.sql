use postgrado_usfx;
CREATE TABLE auditoria (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    tabla_nombre VARCHAR(100) NOT NULL,
    id_registro INT NOT NULL,
    fecha_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    accion ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL
);

-- TRIGGER PARA INSERT
DELIMITER $$

CREATE TRIGGER trg_personas_insert
AFTER INSERT ON personas
FOR EACH ROW
BEGIN
    INSERT INTO auditoria
    (tabla_nombre, id_registro, fecha_hora, accion)
    VALUES
    ('PERSONAS', NEW.id_persona, NOW(), 'INSERT');
END$$

DELIMITER ;

-- Ejemplo de INSERT
INSERT INTO personas
(ci, paterno, materno, nombres, id_tipo_persona)
VALUES
('12345678', 'Rodriguez', 'Lopez', 'Alex', 1);

-- Entonces si ejecutamos la siguiente consulta:
SELECT *
FROM auditoria;

-- Muestra todos los triggers de la base de datos actual
SHOW TRIGGERS;

-- O filtra por una base de datos específica si estás fuera de ella
SHOW TRIGGERS FROM postgrado_usfx;


-- TRIGGER PARA UPDATE
DELIMITER $$

CREATE TRIGGER trg_personas_update
AFTER UPDATE ON personas
FOR EACH ROW
BEGIN
    INSERT INTO auditoria
    (tabla_nombre, id_registro, fecha_hora, accion)
    VALUES
    ('PERSONAS', NEW.id_persona, NOW(), 'UPDATE');
END$$

DELIMITER ;

--Ahora alguien hace:
UPDATE personas
SET nombres = 'Carlos Eduardo'
WHERE id_persona = 5;


-- TRIGGER PARA DELETE
DELIMITER $$

CREATE TRIGGER trg_personas_delete
AFTER DELETE ON personas
FOR EACH ROW
BEGIN
    INSERT INTO auditoria
    (tabla_nombre, id_registro, fecha_hora, accion)
    VALUES
    ('PERSONAS', OLD.id_persona, NOW(), 'DELETE');
END$$

DELIMITER ;

-- La persona desaparece de la tabla personas, pero queda registrada en la tabla auditoria.
DELETE FROM personas
WHERE id_persona = 7;
