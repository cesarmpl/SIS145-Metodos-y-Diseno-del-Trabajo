# Levantar un Servicio con Docker Compose

---

## 📌 ¿Qué significa “levantar un servicio”?

Cuando hablamos de levantar un servicio, nos referimos a ejecutar una aplicación (como una base de datos o servidor) usando Docker

Por ejemplo:
- MySQL  
- PostgreSQL  
- Apache  
- Node.js  

En lugar de instalar todo manualmente, usamos Docker para hacerlo automáticamente.

---

## ¿Cómo se hace?

Se utiliza un archivo llamado:

 `docker-compose.yml`

Este archivo le dice a Docker:
- qué servicio levantar  
- qué configuración usar  
- cómo conectarse  

---
## Ejemplo Real para levantar un Servicio:
***(Revisar los archivos docker-compose.yml que se encuentran en esta misma carpeta)***

## Archivo completo

```yaml
version: '1.0'

networks:
    laravel_network1:
        driver: bridge

volumes:
    db_serverprueba_data:
        driver: local

services:
    
    db_serverprueba:
        image: mysql:8.0
        container_name: db_serverprueba
        restart: unless-stopped
        environment:
            MYSQL_ROOT_PASSWORD: root
            MYSQL_DATABASE: pedidos_db
            MYSQL_PASSWORD: root
        ports:
            - "3311:3306"
        volumes:
            - db_serverprueba_data:/var/lib/mysql
        networks:
            - laravel_network1

```
## Levantar el Contenedor

Para ello, debemos ingresar a la carpeta donde se encuentra nuestro archivo `docker-compose.yml` desde nuestro CMD, por ejemplo:

```bash
cd C:\Users\Usuario\SIS145>
```
Una vez allí ejecutamos el comando:

```bash
C:\Users\Usuario\SIS145> docker compose up -d
```
Y con ello ya tendremos nuestro contenedor activado y listo para usar. Adicionalmente, podemos revisar desde el Dashboard de Docker (Lo que instalamos anteriormente) y ver que efectivamente el servidor se encuentra corriendo.

A su vez, ya podemos iniciar y detener el contenedor desde ese Dashboard cuando nosotros queramos, pulsando el botón *START* que sale a lado del nombre del contenedor como tambien el botón *STOP*.
