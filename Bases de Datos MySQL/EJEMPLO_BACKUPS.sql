CREATE TABLE transacciones_backup (
    id_backup INT AUTO_INCREMENT PRIMARY KEY,

    id_transaccion INT,
    id_persona_programa INT,
    id_usuario INT,
    nit_ci VARCHAR(20),
    nombre_factura VARCHAR(150),
    fecha_emision DATE,
    fecha_transaccion DATETIME,
    monto_total DECIMAL(10,2),

    fecha_backup DATETIME DEFAULT CURRENT_TIMESTAMP,
    accion VARCHAR(20)
);

select * from transacciones_backup
-- Trigger para UPDATE
DELIMITER $$

CREATE TRIGGER trg_transacciones_backup_update
BEFORE UPDATE ON transacciones
FOR EACH ROW
BEGIN

    INSERT INTO transacciones_backup
    (
        id_transaccion,
        id_persona_programa,
        id_usuario,
        nit_ci,
        nombre_factura,
        fecha_emision,
        fecha_transaccion,
        monto_total,
        fecha_backup,
        accion
    )
    VALUES
    (
        OLD.id_transaccion,
        OLD.id_persona_programa,
        OLD.id_usuario,
        OLD.nit_ci,
        OLD.nombre_factura,
        OLD.fecha_emision,
        OLD.fecha_transaccion,
        OLD.monto_total,
        NOW(),
        'UPDATE'
    );

END$$

DELIMITER ;
-- Alguien actualiza una transacción, por ejemplo:
UPDATE transacciones
SET monto_total = 3500
WHERE id_transaccion = 25;
-- y el trigger automáticamente guarda una copia de la transacción antes de la actualización en la tabla transacciones_backup.


--TRIGGER PARA DELETE
-- Supongamos:
DELETE FROM transacciones
WHERE id_transaccion = 2;

-- y el trigger automáticamente guarda una copia de la transacción antes de la eliminación en la tabla transacciones_backup.
DELIMITER $$

CREATE TRIGGER trg_transacciones_backup_delete
BEFORE DELETE ON transacciones
FOR EACH ROW
BEGIN

    INSERT INTO transacciones_backup
    (
        id_transaccion,
        id_persona_programa,
        id_usuario,
        nit_ci,
        nombre_factura,
        fecha_emision,
        fecha_transaccion,
        monto_total,
        fecha_backup,
        accion
    )
    VALUES
    (
        OLD.id_transaccion,
        OLD.id_persona_programa,
        OLD.id_usuario,
        OLD.nit_ci,
        OLD.nombre_factura,
        OLD.fecha_emision,
        OLD.fecha_transaccion,
        OLD.monto_total,
        NOW(),
        'DELETE'
    );

END$$

DELIMITER ;
SHOW TRIGGERS;
