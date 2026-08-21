// 1. Seleccionar o crear la base de datos
use('tienda_online_db');

// Limpieza preventiva (eliminar colecciones si ya existen)
db.productos.drop();
db.clientes.drop();
db.pedidos.drop();


// 2. INSERCIÓN DE DOCUMENTOS (Equivalente a INSERT INTO)


// En MongoDB los campos son dinámicos: no requerimos definir tipos o esquemas rígidos antes.
use('tienda_online_db');
db.productos.insertMany([
  {
    _id: 1, // Si no colocas _id, MongoDB lo genera automáticamente (ObjectId)
    nombre: "Laptop Gaming XYZ",
    precio: 1250.00,
    stock: 15,
    especificaciones: {
      marca: "Asus",
      ram: "16GB",
      almacenamiento: "512GB SSD",
      pantalla: "15.6 pulgadas",
      procesador: "Intel i7"
    }
  },
  {
    _id: 2,
    nombre: "Smartphone Pro Max",
    precio: 899.99,
    stock: 25,
    especificaciones: {
      marca: "Samsung",
      almacenamiento: "256GB",
      camara_mp: 108,
      soporta_5g: true,
      colores_disponibles: ["Negro", "Plata", "Azul"]
    }
  },
  {
    _id: 3,
    nombre: "Polera Deportiva Fit",
    precio: 35.50,
    stock: 50,
    especificaciones: {
      marca: "Nike",
      talla: "L",
      material: "Poliéster",
      genero: "Unisex"
    }
  }
]);

// Insertar un cliente con subdocumentos (direcciones)
db.clientes.insertOne({
  _id: 101,
  nombre: "Juan Pérez",
  email: "juan.perez@email.com",
  direcciones: [
    { tipo: "casa", ciudad: "Sucre", calle: "Av. Las Américas 123" },
    { tipo: "oficina", ciudad: "Sucre", calle: "Calle Calvo 45" }
  ]
});

// Insertar un pedido
db.pedidos.insertOne({
  _id: 5001,
  cliente_id: 101,
  total: 1285.50,
  fecha: new Date(),
  items: [
    { producto_id: 1, cantidad: 1, precio_unitario: 1250.00 },
    { producto_id: 3, cantidad: 1, precio_unitario: 35.50 }
  ]
});


// =================================================================
// 3. CONSULTAS Y FILTROS (Equivalente a SELECT)
// =================================================================

// Consulta general: Ver todos los productos
use('tienda_online_db');
db.productos.find();

// Filtrar por propiedad anidada usando Notación de Punto ("objeto.propiedad")
// Buscar laptops con 16GB de RAM:
db.productos.find({ "especificaciones.ram": "16GB" });

// Proyección: Mostrar solo nombre, precio y marca (excluir el resto de datos)
db.productos.find(
  {}, // Sin filtro (trae todos)
  { nombre: 1, precio: 1, "especificaciones.marca": 1, _id: 0 }
);

// Consulta dentro de un Array (Buscar productos disponibles en color "Negro")
db.productos.find({ "especificaciones.colores_disponibles": "Negro" });


// =================================================================
// 4. ACTUALIZACIÓN Y ELIMINACIÓN
// =================================================================

// Modificar un dato interno del objeto especificaciones ($set)
db.productos.updateOne(
  { _id: 1 },
  { $set: { "especificaciones.ram": "32GB" } }
);

// Eliminar un campo del documento ($unset)
db.productos.updateOne(
  { _id: 1 },
  { $unset: { "especificaciones.procesador": "" } }
);

// Eliminar un documento por su ID
db.productos.deleteOne({ _id: 3 });

use('tienda_online_db');
db.prueba.insertOne({ creado: true });