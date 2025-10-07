

✅ Paso 1: Respaldo de la base de datos (PostgreSQL/PostGIS)

docker exec -t db pg_dump -U geonode -d geonode > geonode_backup.sql
docker exec -t db pg_dump -U geonode_data -d geonode_data > geonode_data_backup.sql

docker exec -t contenedor_postgres pg_dump -U postgres > geonode_backup.sql

--EN MI CONTENEDOR
    docker exec -t db4u_uifs1-geo pg_dump -U geonode -d geonode > 2025_0911_1415_geonode_backup.sql
    docker exec -t db4u_uifs1-geo pg_dump -U geonode_data -d geonode_data > 2025_0911_1415_geonode_data_backup.sql

 
✅ Paso 2: Respaldo de la configuración y datos de GeoServer
Busca el volumen de datos de GeoServer. Generalmente es algo como /geoserver_data dentro del contenedor. Para copiarlo al host:

    docker cp geoserver:/geoserver_data ./backup/geoserver_data

--- MEJOR HACER ESTO (La carpeta requerida es - DATA_DIR - )
    docker run --rm -v u_uifs1-geo-gsdatadir:/data -v $(pwd):/backup alpine tar czf /backup/2025_0911_1415_geoserver_data_dir.tar.gz -C /data .

    - O PUEDE SER CON ESTE
    docker cp geoserver4u_uifs1-geo:/geoserver_data/data ./data_dir_backup


--EN MI CONTENEDOR
docker cp geoserver4u_uifs1-geo:/geoserver_data 2025_0905_1107_geoserver_data


✅ Paso 3: Respaldar archivos subidos a GeoNode (media)

    📁 1. Archivos estáticos/media de GeoNode
    Por ejemplo:

    docker cp django:/mnt/volumes/statics ./backup/geonode_statics


    --EN MI CONTENEDOR
        docker cp django4u_uifs1-geo:/mnt/volumes/statics 2025_0912_1230_django_geonode_statics

        * ó hacer los siguiente
            cp -r /var/lib/docker/volumes/u_uifs1-geo-statics/_data 2025_0912_1218_geonode_media
        ó
            sudo tar czf 2025_0912_1218_geonode_media.tar.gz -C /var/lib/docker/volumes/u_uifs1-geo-statics/_data .


    📁 2. GeoServer Data Directory (data_dir del GeoServer)
    Este volumen se comparte entre GeoNode y el contenedor de configuración gsconf4u_uifs1-geo:

        docker cp geoserver4u_uifs1:/opt/geoserver/data_dir 2025_0912_1230_geoserver_data_dir

        ó
        cp -r /var/lib/docker/volumes/u_uifs1-geo-gsdatadir/_data 2025_0912_1230_geoserver_data_dir








O si se usan otros paths, revisa con:
docker exec -it django find / -name "*.shp"


-- OTROS en MI CONTENEDOR
docker cp django4u_uifs1-geo:/mnt/volumes/static 2025_0905_1107_django_geonode_static
docker cp django4u_uifs1-geo:/mnt/volumes/static 2025_0905_1107_django_geonode_static



✅ Paso 4: Respaldar archivos de configuración (opcional)
Si has modificado local_settings.py o templates:
docker cp django:/usr/src/app/geonode/local_settings.py ./backup/

--EN MI CONTENEDOR (NO SE ENCUENTRA EL ARCHIVO INDICADO)
docker cp django4u_uifs1-geo:/usr/src/app/geonode/local_settings.py 2025_0905_1107_geonode_config



✅ Paso 5: Hacer backup del docker-compose.yml y archivos relacionados

Guarda tu configuración:
cp docker-compose.yml ./backup/
cp .env ./backup/

--EN MI CONTENEDOR (NO SE ENCUENTRA EL ARCHIVO INDICADO)





************************************************************************************************
************************************************************************************************


✅ Identificación de contenedores

Aquí están los contenedores clave de tu instalación:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
Servicio	        Nombre del contenedor	Imagen Docker	                                Estado
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
GeoNode (Django)    django4u_uifs1-geo	    geonode/geonode:latest-ubuntu-22.04	            ✅ Up (healthy)
GeoNode (Celery)	celery4u_uifs1-geo	    geonode/geonode:latest-ubuntu-22.04	            ✅ Up
GeoServer           geoserver4u_uifs1-geo	geonode/geoserver:2.24.3-latest	                🔁 Restarting (hay que revisar)
GeoServer Config	gsconf4u_uifs1-geo	    geonode/geoserver_data:2.24.3-latest	        ✅ Up (healthy)
Base de datos	    db4u_uifs1-geo	        geonode/postgis:15.3-latest	                    ✅ Up (healthy)
nginx	            nginx4u_uifs1-geo	    geonode/nginx:1.25.3-latest	                    ✅ Up
RabbitMQ	        rabbitmq4u_uifs1-geo	rabbitmq:3-alpine	                            ✅ Up
Memcached	        memcached4u_uifs1-geo	memcached:alpine	                            ✅ Up
Let's Encrypt	    letsencrypt4u_uifs1-geo	geonode/letsencrypt:2.6.0-latest	            🔁 Restarting
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -





















Qué respaldar (exactamente)
📁 1. Archivos estáticos/media de GeoNode
sudo tar czf 2025_0912_1218_geonode_media.tar.gz -C /var/lib/docker/volumes/u_uifs1-geo-statics/_data .



#Restaurar base de datos:
1. Asegúrate de que el nuevo contenedor de PostgreSQL esté corriendo.
2. Carga el backup

docker run --rm -v geoserver_data:/data -v $(pwd):/backup alpine \
    tar xzf /backup/geoserver_data_dir.tar.gz -C /data


    
    








****************************************************************************************
****************************************************************************************
#✅ 1. Archivos de configuración (docker-compose, envs, etc.)
Estos definen cómo se lanzan GeoNode, GeoServer, y los servicios como la base de datos.

##🗂 Archivos requeridos:
- docker-compose.yml
- .env (si existe)
- Cualquier carpeta de configuración (por ejemplo, geonode/, geoserver/, data/, nginx/ o similar si está personalizada)
- Cualquier archivo de volúmenes montados desde el host

##🔧 ¿Dónde están?
 Normalmente en un directorio como:
/opt/geonode/

#✅ 2. Backup de la base de datos PostgreSQL/PostGIS
GeoNode usa una base de datos PostgreSQL con extensión PostGIS para:
- Capas y mapas
- Usuarios y permisos
- Registros de GeoServer (catálogo)

## 📦 Instrucciones de backup:
### Encuentra el contenedor de la base de datos:
    docker ps | grep db

### Haz backup completo:
    docker exec -t db4u_uifs1-geo pg_dumpall -U postgres > 2025_0911_0900_geonode_backup.sql
    
    Esto te da una copia completa del estado de la base de datos.

#✅ 3. Datos persistentes (medios, capas subidas, estilos, etc.)
GeoNode y GeoServer almacenan archivos fuera de la base de datos, por ejemplo:
- Medios (archivos subidos, imágenes)
- Estilos de GeoServer (SLD)
- Workspaces o capas configuradas directamente

## Revisa si usas volúmenes de Docker:
    docker volume ls

u_uifs1-geo-dbbackups
u_uifs1-geo-dbdata
u_uifs1-geo-gsdatadir
u_uifs1-geo-nginxcerts
u_uifs1-geo-nginxconfd
u_uifs1-geo-rabbitmq
u_uifs1-geo-statics
u_uifs1-geo-tmp


SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE datname = 'geonode' AND pid <> pg_backend_pid();

Para cada volumen relevante (por ejemplo, de medios o capas):

    docker run --rm  -v u_uifs1-geo-backup-restore:/volume -v $(pwd):/backup alpine tar -czf /backup/202509111015_u_uifs1-geo-backup-restore.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-data:/volume -v $(pwd):/backup alpine tar -czf /backup/202509111015_u_uifs1-geo-data.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-dbbackups:/volume -v $(pwd):/backup alpine tar -czf /backup/202509111015_u_uifs1-geo-dbbackups.tar.gz -C /volume .
    
    docker run --rm -v u_uifs1-geo-dbdata:/volume -v $(pwd):/backup alpine tar -czf /backup/202509111015_u_uifs1-geo-dbdata.tar.gz -C /volume .
    
    docker run --rm -v u_uifs1-geo-gsdatadir:/volume -v $(pwd):/backup alpine tar -czf /backup/202509111015_u_uifs1-geo-gsdatadir.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-nginxcerts:/volume -v $(pwd):/backup alpine tar -czf /backup/202509111015_u_uifs1-geo-nginxcerts.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-nginxconfd:/volume -v $(pwd):/backup alpine tar -czf /backup/202509111015_u_uifs1-geo-nginxconfd.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-rabbitmq:/volume -v $(pwd):/backup alpine tar -czf /backup/202509111015_u_uifs1-geo-rabbitmq.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-statics:/volume -v $(pwd):/backup alpine tar -czf /backup/202509111015_u_uifs1-geo-statics.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-tmp:/volume -v $(pwd):/backup alpine tar -czf /backup/202509111015_u_uifs1-geo-tmp.tar.gz -C /volume .

    docker run --rm -v NAMEVOL:/volume -v $(pwd):/backup alpine tar -czf /backup/202509111015_NAMEVOL.tar.gz -C /volume .
















##Luego identifica cuáles están usados por GeoNode o GeoServer:
docker inspect <nombre_contenedor> | grep Source

🔄 Backup del contenido:




#4. ♻️ Restaurar la base de datos
##Busca el nuevo contenedor de la DB:
    docker ps | grep db

##Copia y restaura el backup:
    docker cp geonode_backup.sql <nombre_contenedor_db>:/geonode_backup.sql
    docker exec -it <nombre_contenedor_db> psql -U postgres -f /geonode_backup.sql


****************************************************************************************
****************************************************************************************










*********************************************************************************************
        RESTAURAR DATOS DE CONTENEDORES DOCKER
**********************************************************************************************

✅ Identificación de contenedores

Aquí están los contenedores clave de tu instalación:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
Servicio	        Nombre del contenedor	Imagen Docker	                                Estado
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
GeoNode (Django)    django4u_uifs1-geo	    geonode/geonode:latest-ubuntu-22.04	            ✅ Up (healthy)
GeoNode (Celery)	celery4u_uifs1-geo	    geonode/geonode:latest-ubuntu-22.04	            ✅ Up
GeoServer           geoserver4u_uifs1-geo	geonode/geoserver:2.24.3-latest	                🔁 Restarting (hay que revisar)
GeoServer Config	gsconf4u_uifs1-geo	    geonode/geoserver_data:2.24.3-latest	        ✅ Up (healthy)
Base de datos	    db4u_uifs1-geo	        geonode/postgis:15.3-latest	                    ✅ Up (healthy)
nginx	            nginx4u_uifs1-geo	    geonode/nginx:1.25.3-latest	                    ✅ Up
RabbitMQ	        rabbitmq4u_uifs1-geo	rabbitmq:3-alpine	                            ✅ Up
Memcached	        memcached4u_uifs1-geo	memcached:alpine	                            ✅ Up
Let's Encrypt	    letsencrypt4u_uifs1-geo	geonode/letsencrypt:2.6.0-latest	            🔁 Restarting
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 1 Enviar datos respaldados a los contenedores
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
a => opcional
    sudo chmod -R u+rw ./2025_0912_1230_django_geonode_statics
 
b => docker cp 2025_0912_1230_django_geonode_statics/. django4u_uifs1-geo:/mnt/volumes/statics

c => cp -r 2025_0912_1230_geoserver_data_dir/* /var/lib/docker/volumes/u_uifs1-geo-gsdatadir/_data

    ó 
    docker cp data_dir_backup/. geoserver4u_uifs1-geo:/geoserver_data/data


/var/lib/docker/volumes/ geoserver4u_uifs1-geo

# 2 Restaurar base de datos:
a => Asegúrate de que el nuevo contenedor de PostgreSQL esté corriendo.
    con [docker ps -a] ver el contendor de base de datos por ejemplo: db4u_uifs1-geo

b => Eliminar la base de datos actual
    ✅ Entrar al contenedor de BD
     docker exec  -it db4u_uifs1-geo bash

    ✅ Entrar a postgres
     psql -U postgres

    ✅ paso 1: Finalizar conexiones activas desde PostgreSQL
        SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'geonode_data'   AND pid <> pg_backend_pid();
    
    ✅ Paso 2: Revocar los privilegios de los roles
     REVOKE ALL PRIVILEGES ON SCHEMA public FROM geonode;
     REVOKE ALL PRIVILEGES ON SCHEMA public FROM geonode_data;

    ✅ Paso 3: Eliminar las BD
     DROP DATABASE geonode;
     DROP DATABASE geonode_data;

    ✅ Paso 4: Eliminar los roles
     DROP ROLE geonode;
     DROP ROLE geonode_data;


c => Cargar y aplicar el backup
    ✅ Copiar Backup al contenedor
    docker cp 2025_0911_0900_geonode_backup.sql  db4u_uifs1-geo:/2025_0911_0900_geonode_backup.sql

    ✅ Cargar datos de backup a la base de datos del contenedor
    docker exec -it db4u_uifs1-geo psql -U postgres -f /2025_0911_0900_geonode_backup.sql


# 3. Verifica conectividad desde GeoNode:
    docker compose exec django sh
    python manage.py showmigrations

    - Sincronizar capas (por si acaso)
     python manage.py updatelayers
     python manage.py rebuild_index


#4 Restaurar el data_dir de GeoServer:

    docker run --rm -v u_uifs1-geo-gsdatadir:/data -v $(pwd):/backup alpine   tar xzf /backup/2025_0911_1415_geoserver_data_dir.tar.gz -C /data
 










