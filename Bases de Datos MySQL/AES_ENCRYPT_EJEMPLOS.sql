-- Al momento de INSERTAR una nueva transacción, el trigger automáticamente guarda una copia de la transacción en la tabla transacciones_backup.
CREATE TABLE transacciones_backup_encriptado (
    id_backup INT AUTO_INCREMENT PRIMARY KEY,
    id_transaccion INT,
    id_persona_programa INT,
    id_usuario INT,
    nit_ci VARBINARY(255),
    nombre_factura VARBINARY(255),
    monto_total VARBINARY(255),
    fecha_emision DATETIME,
    fecha_transaccion DATETIME,
    fecha_backup DATETIME,
    accion VARCHAR(10)
);
use postgrado_usfx;
show TRIGGERS;
DROP TRIGGER IF EXISTS trg_transacciones_backup_insert;
DELIMITER $$

CREATE TRIGGER trg_transacciones_backup_insert
AFTER INSERT ON transacciones
FOR EACH ROW
BEGIN
    INSERT INTO transacciones_backup_encriptado
    (
        id_transaccion,
        id_persona_programa,
        id_usuario,
        nit_ci,
        nombre_factura,
        monto_total,
        fecha_emision,
        fecha_transaccion,
        fecha_backup,
        accion
    )
    VALUES
    (
        NEW.id_transaccion, -- Usamos NEW en lugar de OLD para INSERT
        NEW.id_persona_programa,
        NEW.id_usuario,
        AES_ENCRYPT(NEW.nit_ci, 'usfx2026'),
        AES_ENCRYPT(NEW.nombre_factura, 'usfx2026'),
        AES_ENCRYPT(CAST(NEW.monto_total AS CHAR), 'usfx2026'),
        NEW.fecha_emision,
        NEW.fecha_transaccion,
        NOW(),
        'INSERT'
    );
END$$

DELIMITER ;

-- (Nota: Convertimos NEW.monto_total a CHAR mediante CAST() porque AES_ENCRYPT prefiere cadenas de texto/caracteres para cifrar números decimales correctamente).

SELECT * FROM transacciones_backup_encriptado;

-- Solo veremos numeros raros

-- Una vez descifrado podremos ver los datos reales:
SELECT 
    id_transaccion,
    -- Desciframos los datos y los convertimos de binario a texto/número
    CAST(AES_DECRYPT(nit_ci, 'usfx2026') AS CHAR) AS nit_ci,
    CAST(AES_DECRYPT(nombre_factura, 'usfx2026') AS CHAR) AS nombre_factura,
    CAST(AES_DECRYPT(monto_total, 'usfx2026') AS DECIMAL(10,2)) AS monto_total,
    fecha_backup,
    accion
FROM transacciones_backup_encriptado;

--INSERTAMOS VALORES DE EJEMPLO
INSERT INTO transacciones
(id_persona_programa, id_usuario, nit_ci, nombre_factura,
 fecha_emision, fecha_transaccion, monto_total, estado)
VALUES
(4, 2, '2345678', 'Osvaldo Velasquez',
 '2026-09-01', '2026-09-01 10:30:00', 480.00, 'REGISTRADA');

select * from transacciones;