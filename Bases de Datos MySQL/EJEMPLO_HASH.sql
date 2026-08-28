use postgrado_usfx;
-- Para una demostración académica podemos usar un hash SHA-256 generado por MySQL.

SELECT SHA2('Admin123!', 256);

SELECT password
FROM usuarios
WHERE nombre = 'admin';

-- Los dos deberían producir el mismo hash.

-- También podemos hacer una comparación:
SELECT *
FROM usuarios
WHERE nombre = 'admin'
AND password = SHA2('Admin123!', 256);

-- Si devuelve el usuario: LOGIN CORRECTO
-- Si no devuelve ninguna fila: LOGIN INCORRECTO

-- Ver las tablas y las contraseñas hasheadas
SELECT password
 FROM usuarios;
 
