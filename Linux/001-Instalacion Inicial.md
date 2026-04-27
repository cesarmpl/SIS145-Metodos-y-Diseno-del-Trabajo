# Linux (Ubuntu) – Instalación en Máquina Virtual

---

## ¿Qué vamos a hacer?

Instalar un sistema operativo Linux (Ubuntu Desktop) dentro de una máquina virtual usando VirtualBox.

Este proceso permite:
- practicar Linux sin afectar tu sistema principal  
- crear entornos de prueba  
- trabajar con servidores y servicios  

---

## Concepto clave

Una **máquina virtual** es un sistema operativo que corre dentro de otro.


---

## Requisitos

- Computadora con al menos 8 GB de RAM (recomendado)  
- Espacio libre en disco (mínimo 20 GB)  
- Virtualización activada en BIOS  

---

## Paso 1: Instalar VirtualBox (opcional pero recomendado)

1. Ir a la página oficial:
   https://www.virtualbox.org/


2. Descargar la versión para tu sistema operativo  

3. Ejecutar el instalador  

4. Instalar con configuración por defecto  

---

## Paso 2: Descargar Ubuntu (ISO)

1. Ir a la página oficial:
   https://ubuntu.com/download/desktop
2. Descargar Ubuntu Desktop (archivo `.iso`)  
   Por Ejemplo:
   **ubuntu-22.04-desktop-amd64.iso**

---

## Paso 3: Crear máquina virtual

1. Abrir VirtualBox  
2. Clic en **NEW**
3. Configurar:

    **Nombre:** Ubuntu
    **Tipo:** Linux
    **Versión:** Ubuntu (64-bit)

---

##  Paso 4: Asignar recursos

### Memoria RAM
**Recomendado:** 2048 MB o más
**Ideal:** 4096 MB

---

### Disco duro

Seleccionar **Create a virtual hard disk now**.
**Tipo:** VDI
**Almacenamiento:** Dinámico
**Tamaño:** 20 GB o más

Posterior a todas las configuraciones seleccionar el archivo `.iso` de Ubuntu. La instalación comenzará automáticamente, posterior  ellos, solo sigue los pasos que te indica el Programa de Instalación. 


## 🖥️ Paso 5: Primer inicio

Al iniciar:

- Ingresar usuario y contraseña  
- Ya tendrás Ubuntu listo para  utilizar la terminal y levantar todos los servicios necesarios. 