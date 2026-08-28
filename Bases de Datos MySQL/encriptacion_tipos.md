# Introducción a la seguridad de datos

En una base de datos podemos aplicar diferentes mecanismos de seguridad dependiendo de **qué queremos proteger** y **contra qué amenaza**.

Los tres conceptos que veremos son:

1. **Hashing — SHA-2**
2. **Cifrado físico — TDE**
3. **Cifrado lógico — AES**

---

## 1. Hashes — SHA-2

Un **hash** transforma un dato en una cadena de caracteres de longitud fija.

Es un proceso **unidireccional**, es decir, está diseñado para generar una representación del dato original, pero **no para recuperar el dato a partir del hash**.

### ¿Para qué se utilizan?

Los hashes pueden utilizarse para:

* Almacenar contraseñas de forma segura, junto con buenas prácticas adicionales.
* Verificar la integridad de información.
* Generar identificadores o huellas digitales de datos.
* Detectar si un archivo o dato ha sido modificado.

### Ejemplo

Tenemos el siguiente dato:

```text
Hola123
```

Aplicamos SHA-256:

```text
"Hola123"
     ↓
   SHA-256
     ↓
7f...a91
```

El resultado será una cadena de caracteres que representa una **huella digital** del dato.

> **Importante:** un hash **no es cifrado**. Su objetivo no es permitir recuperar el texto original.

###  Ejemplo sencillo

Podemos imaginar un hash como una **huella dactilar**:

```text
Persona
   ↓
Huella digital
```

La huella permite identificar o comparar, pero no podemos reconstruir a la persona únicamente a partir de ella.

---

# 2. Cifrado físico — TDE

**TDE (Transparent Data Encryption)** es una tecnología utilizada para proteger los datos de una base de datos **mientras están almacenados físicamente en el disco**.

Su objetivo principal es proteger frente a situaciones como:

* Robo del disco.
* Robo del servidor.
* Copia directa de los archivos de la base de datos.
* Acceso físico no autorizado al almacenamiento.

### ¿Cómo funciona conceptualmente?

```text
Base de datos
      ↓
Archivos almacenados en disco
      ↓
     TDE
      ↓
Datos almacenados de forma cifrada
```

Por ejemplo, una base de datos puede contener:

```text
usuarios.mdf
usuarios.ldf
```

Si el almacenamiento está protegido mediante TDE, los datos contenidos en esos archivos se encuentran cifrados.

### Idea principal

TDE protege **los datos en reposo**.

Es decir:

> **“¿Qué pasa si alguien consigue físicamente los archivos de mi base de datos?”**

TDE busca evitar que esa persona pueda leer directamente la información almacenada.

### Importante

TDE **no significa que cada dato de la tabla aparezca cifrado para el usuario que consulta normalmente la base de datos**.

Su objetivo está principalmente en proteger el almacenamiento físico.

---

# 3. Cifrado lógico — AES

El **cifrado lógico** permite proteger determinados datos dentro de la propia aplicación o base de datos.

A diferencia de un hash, el cifrado es **reversible** siempre que se disponga de la clave correcta.

Uno de los algoritmos más conocidos es **AES (Advanced Encryption Standard)**.

### ¿Para qué podemos utilizarlo?

Podríamos utilizar cifrado para proteger información especialmente sensible, por ejemplo:

* Información de tarjetas.
* Documentos o identificadores sensibles.
* Información privada.
* Información que necesite protección adicional.

### Ejemplo conceptual

Tenemos:

```text
Dato original
     ↓
 AES + clave
     ↓
Dato cifrado
```

Para recuperar la información:

```text
Dato cifrado
     ↓
 Clave correcta
     ↓
Dato original
```

Por ejemplo:

```text
Texto original:

"123456789"

        ↓ AES + clave

"8F3A91D72C..."

        ↓ Clave correcta

"123456789"
```

###  Idea principal

El cifrado AES responde a la pregunta:

> **“¿Cómo protejo un dato específico pero necesito poder recuperarlo posteriormente?”**

---

#  Diferencia entre Hashing y Cifrado

Una de las diferencias más importantes es:

| Característica                   | Hash — SHA-2                     | Cifrado — AES   |
| -------------------------------- | -------------------------------- | --------------- |
| Tipo de proceso                  | Unidireccional                   | Reversible      |
| ¿Se recupera el original?        |  No                             |  Sí            |
| Utiliza una clave para descifrar |  No                             |  Sí            |
| Uso típico                       | Contraseñas, integridad, huellas | Datos sensibles |
| Ejemplo                          | SHA-256                          | AES             |

### Ejemplo sencillo

**Hash:**

```text
"Hola123"
    ↓
 SHA-256
    ↓
"abc123..."
```

No buscamos recuperar `"Hola123"`.

---

**Cifrado:**

```text
"Hola123"
    ↓
 AES + clave
    ↓
"X8f92..."
    ↓
 AES + clave
    ↓
"Hola123"
```

Aquí **sí necesitamos recuperar el dato original**.

---

#  Diferencia entre TDE y AES

También podemos diferenciar el **cifrado físico** del **cifrado lógico**.

| Característica            | TDE                      | AES lógico                     |
| ------------------------- | ------------------------ | ------------------------------ |
| Nivel                     | Almacenamiento           | Dato / aplicación              |
| Protege                   | Base de datos en disco   | Datos específicos              |
| Objetivo                  | Proteger datos en reposo | Proteger información sensible  |
| ¿Permite recuperar datos? |  Sí                     |  Sí                           |
| Ejemplo de amenaza        | Robo del disco           | Acceso no autorizado a un dato |

Podemos imaginarlo así:

```text
                 SEGURIDAD DE DATOS
                        │
          ┌─────────────┼─────────────┐
          │             │             │
       HASH          CIFRADO       CIFRADO
       SHA-2          TDE            AES
          │             │             │
          ↓             ↓             ↓
      Huellas       Disco/BD      Datos específicos
      Integridad    almacenada     sensibles
```

---

#  Resumen rápido

###  SHA-2 — Hash

> **“Quiero obtener una huella del dato.”**

No está diseñado para recuperar el dato original.

```text
Dato → SHA-2 → Hash
```

---

###  TDE — Cifrado físico

> **“Quiero proteger mi base de datos si alguien obtiene físicamente los archivos o el almacenamiento.”**

```text
BD → TDE → Datos protegidos en disco
```

---

###  AES — Cifrado lógico

> **“Quiero proteger determinados datos y poder recuperarlos posteriormente utilizando una clave.”**

```text
Dato → AES + clave → Dato cifrado
Dato cifrado → AES + clave → Dato original
```

---

#  Una forma sencilla de recordarlo

Podemos resumir los tres conceptos con tres preguntas:

> **HASH:** ¿Quiero obtener una huella del dato?

> **TDE:** ¿Quiero proteger la base de datos almacenada físicamente?

> **AES:** ¿Quiero cifrar un dato y poder recuperarlo con una clave?

---

