

************************************************************************************************
* * *  ✅  Identificación de contenedores
************************************************************************************************

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




***********************************************************************************************
* * *  ✅ REALIZAR RESPALDOS
***********************************************************************************************

✅ Paso 1: Respaldo de la base de datos (PostgreSQL/PostGIS)

# Dump de geonode (metadatos)
docker exec -t db pg_dump -U geonode -d geonode > geonode_backup.sql
# Dump de geonode_data (datos espaciales)
docker exec -t db pg_dump -U geonode_data -d geonode_data > geonode_data_backup.sql


docker exec -t contenedor_postgres pg_dump -U postgres > geonode_backup.sql

--EN MI CONTENEDOR
    # Dump de geonode (metadatos)
    docker exec -t db4u_uifs1-geo pg_dump -U geonode -d geonode > 2025_0911_1415_geonode_backup.sql
    
    # Dump de geonode_data (datos espaciales)
    docker exec -t db4u_uifs1-geo pg_dump -U geonode_data -d geonode_data > 2025_0911_1415_geonode_data_backup.sql



✅ 2. Respaldar Archivos 

# Archivos de medios - SOLO UPLOADED
    docker cp geonode:/usr/src/app/geonode/uploaded ./backup_uploaded

--EN MI CONTENEDOR
    docker cp django4u_uifs1-geo:/mnt/volumes/statics/uploaded ./backup_medios_uploaded

##  Toda la carpeta de medios (la que contiene a la carpeta UPLOADED)
    docker cp django4u_uifs1-geo:/mnt/volumes/statics 2025_0912_1230_django_geonode_statics
    
    ó
    - cp -r /var/lib/docker/volumes/u_uifs1-geo-statics/_data 2025_0912_1218_geonode_media
    
    ó
    - sudo tar czf 2025_0912_1218_geonode_media.tar.gz -C /var/lib/docker/volumes/u_uifs1-geo-statics/_data .


# Respaldo de la configuración y datos de GeoServer
 docker run --rm -v u_uifs1-geo-gsdatadir:/data -v $(pwd):/backup alpine tar czf /backup/2025_1008_1158_geoserver_data_dir.tar.gz -C /data .
 
 - O PUEDE SER CON ESTE
    docker cp geoserver4u_uifs1-geo:/geoserver_data/data ./2025_1008_1158_geoserver_data_dir


# O si se usan otros paths, revisa con:
docker exec -it django4u_uifs1-geo find / -name "*.shp"


✅ Paso 3: Respaldar archivos de configuración (opcional), Si has modificado local_settings.py o templates:
    docker cp django:/usr/src/app/geonode/local_settings.py ./backup/

    - EN MI CONTENEDOR (NO SE ENCUENTRA EL ARCHIVO INDICADO)
        docker cp django4u_uifs1-geo:/usr/src/app/geonode/local_settings.py 2025_0905_1107_geonode_config

    - o buscar el archivo con:
        sudo find /var/lib/docker -name  "*local_settings.py"



**** LO SIGUIENTE ANALIZAR SI ES PERTINENTE REALIZARLO
# RESPALDAR VOLUMENES DIRECTAMENTE - Revisa si usas volúmenes de Docker:
    docker volume ls

    u_uifs1-geo-dbbackups
    u_uifs1-geo-dbdata
    u_uifs1-geo-gsdatadir
    u_uifs1-geo-nginxcerts
    u_uifs1-geo-nginxconfd
    u_uifs1-geo-rabbitmq
    u_uifs1-geo-statics
    u_uifs1-geo-tmp


## Para cada volumen relevante (por ejemplo, de medios o capas):

    docker run --rm  -v u_uifs1-geo-backup-restore:/volume -v $(pwd):/backup alpine tar -czf /backup/202510081301_u_uifs1-geo-backup-restore.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-data:/volume -v $(pwd):/backup alpine tar -czf /backup/202510081301_u_uifs1-geo-data.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-dbbackups:/volume -v $(pwd):/backup alpine tar -czf /backup/202510081301_u_uifs1-geo-dbbackups.tar.gz -C /volume .
    
    - docker run --rm -v u_uifs1-geo-dbdata:/volume -v $(pwd):/backup alpine tar -czf /backup/202510081301_u_uifs1-geo-dbdata.tar.gz -C /volume .
    
    docker run --rm -v u_uifs1-geo-gsdatadir:/volume -v $(pwd):/backup alpine tar -czf /backup/202510081301_u_uifs1-geo-gsdatadir.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-nginxcerts:/volume -v $(pwd):/backup alpine tar -czf /backup/202510081301_u_uifs1-geo-nginxcerts.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-nginxconfd:/volume -v $(pwd):/backup alpine tar -czf /backup/202510081301_u_uifs1-geo-nginxconfd.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-rabbitmq:/volume -v $(pwd):/backup alpine tar -czf /backup/202510081301_u_uifs1-geo-rabbitmq.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-statics:/volume -v $(pwd):/backup alpine tar -czf /backup/202510081301_u_uifs1-geo-statics.tar.gz -C /volume .

    docker run --rm -v u_uifs1-geo-tmp:/volume -v $(pwd):/backup alpine tar -czf /backup/202510081301_u_uifs1-geo-tmp.tar.gz -C /volume .













 

***********************************************************************************************
* * *  ✅ RESTAURAR DATOS DE CONTENEDORES DOCKER
***********************************************************************************************

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 1 Enviar datos respaldados a los contenedores
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
( opcional )
    sudo chmod -R u+rw ./2025_0912_1230_django_geonode_statics
 
a => docker cp 2025_0912_1230_django_geonode_statics/. django4u_uifs1-geo:/mnt/volumes/statics
    -- ó --
    docker cp 2025_0912_1230_django_geonode_statics/uploaded/. django4u_uifs1-geo:/mnt/volumes/statics/uploaded

b => sudo cp -r 2025_0912_1230_geoserver_data_dir/* /var/lib/docker/volumes/u_uifs1-geo-gsdatadir/_data

    -- ó --    
    sudo chmod -R u+rw ./2025_0912_1230_geoserver_data_dir_2
    docker cp  geoserver4u_uifs1-geo:/var/geoserver_data/
    docker cp geoserver4u_uifs1-geo:/geoserver_data/data ./2025_1009_1400_geoserver_data_dir_ok
    docker cp ./2025_0912_1230_geoserver_data_dir_2/. geoserver4u_uifs1-geo:/geoserver_data 

    - Esto es para ver la carpeta en donde se copian los datos
    sudo ls /var/lib/docker/volumes/u_uifs1-geo-gsdatadir/_data

    --- ESTE SI COPIA TODO
docker cp ./2025_0912_1230_geoserver_data_dir_2/. geoserver4u_uifs1-geo:/geoserver_data 



sudo ls -oh /var/lib/docker/volumes/u_uifs1-geo-statics/_data
sudo ls -oh /var/lib/docker/volumes/u_uifs1-geo-gsdatadir

# 2 Restaurar base de datos:
a => Asegúrate de que el nuevo contenedor de PostgreSQL esté corriendo.
    con [docker ps -a] ver el contendor de base de datos por ejemplo: db4u_uifs1-geo

b => Eliminar la base de datos actual
    ✅ Entrar al contenedor de BD
     docker exec  -it db4u_uifs1-geo bash

    ✅ Entrar a postgres
     psql -U postgres

    ✅ paso 1: Finalizar conexiones activas desde PostgreSQL
    - SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'geonode'   AND pid <> pg_backend_pid();
    - SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'geonode_data'   AND pid <> pg_backend_pid();
    
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
    - docker cp 2025_0911_0900_geonode_backup.sql  db4u_uifs1-geo:/2025_0911_0900_geonode_backup.sql
    - docker cp 2025_0905_1107_geonode_data_backup.sql  db4u_uifs1-geo:/2025_0905_1107_geonode_data_backup.sql

    ✅ Cargar datos de backup a la base de datos del contenedor
    docker exec -it db4u_uifs1-geo psql -U postgres -f /2025_0911_0900_geonode_backup.sql
    // docker exec -it db4u_uifs1-geo psql -U postgres -f /2025_0905_1107_geonode_data_backup.sql
    docker exec -it db4u_uifs1-geo psql -U postgres -d geonode_data -f /2025_0905_1107_geonode_data_backup.sql

    ✅ Comandos de apoyo
    - Conocer las bases de datos de Postgres
    SELECT datname FROM pg_database;
    - Conocer los usuarios registrados
    SELECT id, username, email FROM auth_user;
    - Comando para listar todas las bases de datos disponibles en el contenedor:
    docker exec -it db4u_uifs1-geo psql -U postgres -c '\l'
    - Crear la base de datos =geonode_data=
    docker exec -it db4u_uifs1-geo psql -U postgres -c "CREATE DATABASE geonode_data OWNER geonode;"
    docker exec -it db4u_uifs1-geo psql -U postgres -c "CREATE ROLE geonode_data;"
    docker exec -it db4u_uifs1-geo psql -U postgres -c "CREATE ROLE geonode_data LOGIN;"
    docker exec -it db4u_uifs1-geo psql -U postgres -c "CREATE DATABASE geonode_data OWNER geonode_data;" (ESTE FUNCIONA)

# 3. Verifica conectividad desde GeoNode:
    docker exec -it django4u_uifs1-geo sh
    python manage.py showmigrations

    - Sincronizar capas (por si acaso)
     python manage.py updatelayers
     // python manage.py rebuild_index //Parece obsoleto para esta versión
     Este comando:
        - Reescanea todas las capas publicadas en GeoServer.
        - Actualiza los metadatos en la base de datos de GeoNode.
        - Reconstruye los índices de búsqueda internamente (según el backend configurado).
    - Se puede hacer desde el host con el comando
    docker exec -it django4u_uifs1-geo python manage.py updatelayers

6. 🚀 Reinicia servicios Django y GeoServer
    - Después de restaurar las bases de datos, reinicia:
    docker restart django4u_uifs1-geo
    docker restart geoserver4u_uifs1-geo

    - Y luego reindexa con:
    docker exec -it django4u_uifs1-geo bash
    python manage.py updatelayers



#4 Restaurar el data_dir de GeoServer: // al hacer esto se truena el GEOSERVER

    docker run --rm -v u_uifs1-geo-gsdatadir:/data -v $(pwd):/backup alpine   tar xzf /backup/2025_0911_1415_geoserver_data_dir.tar.gz -C /data


# otras cosas a realizar 

## Crear migraciones nuevas para reflejar los modelos actuales:
docker exec -it django4u_uifs1-geo python manage.py makemigrations

## Aplicar esas migraciones:
docker exec -it django4u_uifs1-geo python manage.py migrate

## Actualizar los LINK del server anterior
docker exec -it django4u_uifs1-geo python manage.py migrate_baseurl --source-address=http://186.96.43.8:8087 --target-address=http://localhost:8087





# Conocer la Version de GEONODE
- Opción 1 - 
    docker exec -it django4u_uifs1-geo bash
    python3 -m pip show geonode

- Opción 2 - desde el contenedor
    docker exec -it django4u_uifs1-geo bash
    python3 manage.py shell
    import geonode
    print(geonode.__version__)

- Opción 3 - en la carpeta de instalación
    cat requirements.txt | grep geonode












-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--------   C U I D A D O - ELIMINA VOLUMENES --- ----- ----- ----- ---- ---- ------
-----------------------------------------------------------------------------------
docker volume rm  u_uifs1-geo-backup-restore u_uifs1-geo-data u_uifs1-geo-dbbackups u_uifs1-geo-dbdata u_uifs1-geo-gsdatadir u_uifs1-geo-nginxcerts u_uifs1-geo-nginxconfd u_uifs1-geo-rabbitmq u_uifs1-geo-statics u_uifs1-geo-tmp
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------






