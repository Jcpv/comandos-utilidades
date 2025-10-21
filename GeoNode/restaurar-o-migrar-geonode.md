

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
* * *  ✅ RESTAURAR DATOS DE CONTENEDORES DOCKER
***********************************************************************************************

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 1 Enviar datos respaldados a los contenedores
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
( opcional )
    sudo chmod -R u+rw ./2025_0912_1230_django_geonode_statics

Otros permisos
    chmod -R 755 /geoserver_data/data
    chown -R 1000:1000 /geoserver_data/data
 
a => docker cp 2025_0912_1230_django_geonode_statics/. django4u_uifs1-geo:/mnt/volumes/statics   -- Ok --
    -- ó --
    docker cp 2025_0912_1230_django_geonode_statics/uploaded/. django4u_uifs1-geo:/mnt/volumes/statics/uploaded     

b => sudo chmod -R u+rw ./2025_0912_1230_geoserver_data_dir
docker cp ./2025_0912_1230_geoserver_data_dir/. geoserver4u_uifs1-geo:/geoserver_data         -- Ok -- 

    sudo cp -r 2025_0912_1230_geoserver_data_dir/* /var/lib/docker/volumes/u_uifs1-geo-gsdatadir/_data

    -- para hacer respaldo de misma carpet del HOST --    
    
    docker cp geoserver4u_uifs1-geo:/geoserver_data/data ./2025_1009_1400_geoserver_data_dir_ok-HOST     -- Ok -- (esto es para copiar un respaldo del DOcker actual)
    
    
    --- ESTE SI COPIA TODO
    docker cp ./2025_0912_1230_geoserver_data_dir_2/. geoserver4u_uifs1-geo:/geoserver_data
    docker cp ./2025_1009_1400_geoserver_data_dir_LOCALHOST_ok/. geoserver4u_uifs1-geo:/geoserver_data 

    // PARA RESTAURAR EL CONTENIDO DE LA CARPETA
    CARPERA DIRECTA EN EL HOST - Datos de GEOSERVER
    sudo ls -oh /var/lib/docker/volumes/u_uifs1-geo-gsdatadir/_data

    CARPERA DIRECTA EN EL HOST - Datos de Statics
    sudo ls -oh /var/lib/docker/volumes/u_uifs1-geo-statics/_data


    carpetas que copie para restaurar -- ESTO FUE POR UN ERROR QUE ENCONTRÉ
        sudo cp -r 2025_1009_1400_geoserver_data_dir_LOCALHOST_ok/. /var/lib/docker/volumes/u_uifs1-geo-gsdatadir/_data
        sudo cp -r 2025_0912_1230_geoserver_data_dir/data/gwc /var/lib/docker/volumes/u_uifs1-geo-gsdatadir/_data
        sudo cp -r 2025_0912_1230_geoserver_data_dir/data/gwc-layers /var/lib/docker/volumes/u_uifs1-geo-gsdatadir/_data
        sudo cp -r 2025_0912_1230_geoserver_data_dir/data/legendsamples /var/lib/docker/volumes/u_uifs1-geo-gsdatadir/_data
        sudo cp -r 2025_0912_1230_geoserver_data_dir/data/logs /var/lib/docker/volumes/u_uifs1-geo-gsdatadir/_data
        sudo cp -r 2025_0912_1230_geoserver_data_dir/data/workspaces /var/lib/docker/volumes/u_uifs1-geo-gsdatadir/_data

    docker restart geoserver4u_uifs1-geo



# 2 Restaurar base de datos:
a => Asegúrate de que el nuevo contenedor de PostgreSQL esté corriendo.
    con [docker ps -a] ver el contendor de base de datos por ejemplo: db4u_uifs1-geo

b => Eliminar la base de datos actual           -- Ok --
    ✅ Entrar al contenedor de BD
     docker exec  -it db4u_uifs1-geo bash

    ✅ Entrar a postgres
     psql -U postgres

    ✅ paso 1: Finalizar conexiones activas desde PostgreSQL
     SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'geonode'   AND pid <> pg_backend_pid();
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

     DROP ROLE postgres;

     docker exec -it db4u_uifs1-geo psql -U postgres -l

    ✅ Paso 5: Eliminar los Esquemas
        DROP SCHEMA IF EXISTS tiger CASCADE;
        DROP SCHEMA IF EXISTS tiger_data CASCADE;
        DROP SCHEMA IF EXISTS topology CASCADE;

        - ó
        docker exec -it db4geonode1 psql -U geonode -d geonode -c "DROP SCHEMA tiger CASCADE;"
        docker exec -it db4geonode1 psql -U geonode -d geonode -c "DROP SCHEMA tiger_data CASCADE;"
        docker exec -it db4geonode1 psql -U geonode -d geonode -c "DROP SCHEMA topology CASCADE;"



c => Cargar y aplicar el backup
    ✅ Copiar Backup al contenedor
        docker cp 2025_0905_1107_geonode_backup.sql  db4u_uifs1-geo:/2025_0911_0900_geonode_backup.sql                  -- Ok --
        docker cp 2025_0905_1107_geonode_data_backup.sql  db4u_uifs1-geo:/2025_0905_1107_geonode_data_backup.sql        -- Ok --

    ✅ Cargar datos de backup a la base de datos del contenedor
        docker exec -it db4u_uifs1-geo psql -U postgres -f /2025_0905_1107_geonode_backup.sql                           -- Ok --
        docker exec -it db4u_uifs1-geo psql -U postgres -d geonode_data -f /2025_0905_1107_geonode_data_backup.sql      -- Ok --

    ✅ - - - - - Comandos de apoyo - - - - - 
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



# otras cosas a realizar 

## Crear migraciones nuevas para reflejar los modelos actuales:
docker exec -it django4u_uifs1-geo python manage.py makemigrations

## Aplicar esas migraciones:
docker exec -it django4u_uifs1-geo python manage.py migrate

## Actualizar los LINK del server anterior
docker exec -it django4u_uifs1-geo python manage.py migrate_baseurl --source-address=http://186.96.43.8:8087 --target-address=https://uifs.cimsur.unam.mx:8091

docker exec -it django4u_uifs1-geo python manage.py migrate_baseurl --source-address=http://186.96.43.8:8080/geoserver --target-address=https://uifs.cimsur.unam.mx:8091/geoserver

docker exec -it django4u_uifs1-geo python manage.py migrate_baseurl --source-address=http://186.96.43.8:8080/geoserver/wms --target-address=https://uifs.cimsur.unam.mx:8080/geoserver/wms



* * * 


docker exec -it django4u_uifs1-geo python manage.py updatelayers




* * * * *  URL para pruebas de funcionamiento * * * * * * * * 
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
https://uifs.cimsur.unam.mx:8091/geoserver/ows?service=WMS&request=GetCapabilities
https://uifs.cimsur.unam.mx:8091/api/



- Pruebas de bases de datos 
    docker exec -it geonode_db psql -U geonode geonode

- Pruebas de comandos administrativos / Entra al contenedor geonode:
    docker exec -it django4u_uifs1-geo bash
        python manage.py check
        python manage.py migrate --plan

        * Si no hay errores, la migración de Django está en orden.

- borrando los archivos viejos estáticos
    docker exec -it django4u_uifs1-geo bash
        python manage.py collectstatic --clear --noinput

- Si quieres ver exactamente de qué apps vienen los archivos duplicados, puedes usar:
  python manage.py findstatic geonode/img/logo.png --verbosity 2