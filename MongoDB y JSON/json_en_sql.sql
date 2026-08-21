-- 1. Crear base de datos y seleccionarla
USE practica01aux;

-- Limpieza preventiva en caso de reinstalación
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS productos;

-- 2. Tabla Clientes (guarda direcciones en formato JSON)
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    -- JSON para guardar múltiples direcciones (casa, trabajo, etc.)
    direcciones JSON
);

-- 3. Tabla Productos (guarda especificaciones técnicas variables en JSON)
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    -- JSON para atributos dinámicos (marca, color, procesador, memoria, etc.)
    especificaciones JSON,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Tabla Pedidos (relacionada con Clientes)
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    -- JSON para guardar un snapshot o historial de los artículos comprados
    resumen_carrito JSON,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);


-- INSERCIÓN DE DATOS DE PRUEBA

-- Inserción de Productos con diferentes estructuras JSON
INSERT INTO productos (nombre, precio, stock, especificaciones) VALUES 
(
    'Laptop Gaming XYZ', 
    1250.00, 
    15, 
    '{"marca": "Asus",
     "ram": "16GB",
      "almacenamiento": "512GB SSD", 
      "pantalla": "15.6 pulgadas", 
      "procesador": "Intel i7"}'
),
(
    'Smartphone Pro Max', 
    899.99, 
    25, 
    '{"marca": "Samsung", "almacenamiento": "256GB", "camara_mp": 108, "5g": true, "colores_disponibles": ["Negro", "Plata", "Azul"]}'
),
(
    'Polera Deportiva Fit', 
    35.50, 
    50, 
    '{"marca": "Nike", "talla": "L", "material": "Poliéster", "genero": "Unisex"}'
);

-- Inserción de Clientes
INSERT INTO clientes (nombre, email, direcciones) VALUES 
(
    'Juan Pérez', 
    'juan.perez@email.com', 
    '[{"tipo": "casa", "ciudad": "Sucre", "calle": "Av. Las Américas 123"}, {"tipo": "oficina", "ciudad": "Sucre", "calle": "Calle Calvo 45"}]'
);

-- Inserción de Pedidos
INSERT INTO pedidos (id_cliente, total, resumen_carrito) VALUES 
(
    1, 
    1285.50, 
    '[{"id_producto": 1, "cantidad": 1, "precio": 1250.00}, {"id_producto": 3, "cantidad": 1, "precio": 35.50}]'
);

-- CONSULTAS PRÁCTICAS UTILIZANDO FUNCIONES JSON EN MYSQL


-- 1. Extraer campos JSON con el operador ->> (Devuelve texto limpio sin comillas)
SELECT 
    nombre, 
    precio, 
    especificaciones->>'$.marca' AS marca,
    especificaciones->>'$.almacenamiento' AS almacenamiento
FROM productos;

-- 2. Filtrar registros por atributos JSON (Buscar laptops con 16GB de RAM)
SELECT * 
FROM productos 
WHERE especificaciones->>'$.ram' = '16GB';

-- 4. Modificar un atributo JSON sin sobrescribir todo el objeto (Actualizar la RAM de un producto)
UPDATE productos 
SET especificaciones = JSON_SET(especificaciones, '$.ram', '32GB')
WHERE id_producto = 1;

-- Comprobar actualización
SELECT nombre, especificaciones->>'$.ram' AS ram_actualizada FROM productos WHERE id_producto = 1;


-- UTILIZANDO EL DELETE DENTRO DEL JSON 

-- Quitarle la propiedad "ram" de su objeto JSON
UPDATE productos 
SET especificaciones = JSON_REMOVE(especificaciones, '$.ram')
WHERE id_producto = 1;

-- borrar únicamente el primer color ("Negro", que está en la posición [0])
UPDATE productos 
SET especificaciones = JSON_REMOVE(especificaciones, '$.colores_disponibles[0]')
WHERE id_producto = 2;

-- Eliminar filas según una condición DENTRO del JSON
DELETE FROM productos 
WHERE especificaciones->>'$.marca' = 'Nike';