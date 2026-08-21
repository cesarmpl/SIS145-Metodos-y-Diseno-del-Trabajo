# Introducción a JSON (.json)

> **¿Qué es JSON?**  
> Significa *JavaScript Object Notation* (Notación de Objetos de JavaScript). Es el formato estándar de texto plano más utilizado en el desarrollo web para intercambiar y almacenar datos entre un servidor (backend) y una aplicación (frontend/móvil).

---

## 1. Estructura Básica y Sintaxis

Un archivo `.json` almacena información estructurada en pares de **clave-valor**.

```json
{
    "nombre": "Juan",
    "edad": 22,
    "ciudad": "Sucre"
}
```

### Anatomía del formato:
* **`{ }` (Llaves):** Delimitan un **objeto**. Todo el contenido principal va dentro de llaves.
* **`"nombre"` (Clave / Propiedad):** Debe ir **siempre entre comillas dobles (`" "`)**.
* **`:` (Dos puntos):** Separa la clave de su valor correspondiente.
* **`"Juan"` (Valor):** La información asignada a la clave.
* **`,` (Coma):** Separa una propiedad de la siguiente. 

> 
---

## 2. Tipos de Datos Permitidos en JSON

JSON admite solo un conjunto limitado de tipos de datos básicos:

```json
{
    "nombre": "Juan",
    "edad": 22,
    "promedio": 85.5,
    "activo": true,
    "telefono": null
}
```

### Desglose de tipos:
1. **String (Cadena de texto):** Siempre entre comillas dobles (`"Juan"`).
2. **Number (Número):** Enteros (`22`) o decimales (`85.5`). Sin comillas.
3. **Boolean (Booleano):** Solo `true` o `false` (en minúsculas, sin comillas).
4. **Null (Nulo):** Representa la ausencia explícita de un valor (`null`).
5. **Object (Objeto):** Otra estructura `{ ... }`.
6. **Array (Lista / Arreglo):** Una colección `[ ... ]`.

>  **Lo que NO se puede incluir en JSON:**  
> Funciones, comentarios (`//` o `/* */`), undefined, ni fechas nativas (las fechas se guardan como texto, por ejemplo: `"2026-08-18"`).

---

## 3. Estructuras Avanzadas y Anidadas

A medida que los datos crecen, podemos combinar objetos y arreglos para representar información más compleja.

### A. Objeto dentro de un Objeto (Objetos Anidados)
Permite agrupar propiedades relacionadas bajo un solo concepto.

```json
{
    "nombre": "Juan",
    "direccion": {
        "calle": "Av. Las Americas",
        "numero": 123,
        "ciudad": "Sucre"
    }
}
```

---

### B. Arreglo o Lista (`Array`)
Usa corchetes **`[ ]`** para almacenar una lista ordenada de valores del mismo tipo o varios tipos.

```json
{
    "nombre": "Juan",
    "telefonos": [
        "70000000",
        "60000000"
    ]
}
```

---

### C. Arreglo de Objetos (Estructura Multinivel)
 **¡El concepto más importante para trabajar con APIs!**  
La mayoría de las respuestas de servicios web (como listas de usuarios, productos o datos) utilizan esta combinación: una lista donde cada elemento es un objeto independiente.

```json
{
    "nombre": "Juan",
    "edad": 22,
    "telefonos": [
        {
            "numero": "70000000",
            "tipo": "personal",
            "principal": true
        },
        {
            "numero": "60000000",
            "tipo": "trabajo",
            "principal": false
        }
    ]
}
```

---