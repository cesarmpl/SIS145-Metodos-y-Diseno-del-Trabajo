# Conexión a Base de Datos desde Visual Studio Code

---

## ¿Qué vamos a hacer?

Conectar Visual Studio Code a una base de datos MySQL que está corriendo en Docker, configurar los datos correctamente y guardar la conexión para reutilizarla.

---

## Requisitos previos

- Tener Visual Studio Code instalado  
- Tener Docker en ejecución  
- Tener un contenedor MySQL activo  

Ejemplo de puertos en Docker:

**3311:3306**


---

##  Paso 1: Instalar extensión

1. Abrir Visual Studio Code  
2. Ir a la sección de extensiones  
3. Buscar: `Database Client`  
4. Instalar la extensión  

Opcional:  
- `Database Client JDBC`

---

## Paso 2: Ubicar el panel

Después de instalar:

- Aparece un ícono de base de datos (forma de cilindro)  
- Está en la barra lateral izquierda  

Ese ícono abre el panel de conexiones.

---

## Paso 3: Crear conexión

1. Clic en el ícono de base de datos  
2. Seleccionar: `New Connection`  
3. Elegir: `MySQL`

---

## Paso 4: Configuración

Completar los campos así:

**Host:** 127.0.0.1
**Puerto:** 3311
**Usuario:** root
**Contraseña:** root
**Base de datos:** pedidos_db

---

## Paso 5: Probar conexión

Presionar:

**Test Connection**


Resultado esperado:

**Conexión exitosa**


---

## Paso 6: Guardar conexión

1. Presionar: `Save`  
2. Nombre sugerido:

**MySQL-Docker**


---

## Paso 7: Usar la conexión

Una vez guardada:

- Aparece en la lista  
- Permite:

  - Ver bases de datos  
  - Ver tablas  
  - Ejecutar consultas SQL  
  - Insertar datos  

Podemos iniciar haciendo un básico:

```sql
CREATE DATABASE SIS145;
USE SIS145;
```
Todo esto en la pestaña "query" donde puede realizar las consultas que desees.

**Nota:** Los mismos pasos se aplican en caso de que fuera otro contenedor con otro servicio, como por ejemplo uno con **POSTGRESQL**.