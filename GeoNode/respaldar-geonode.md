

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

##  Toda la carpeta de medios (la que contiene a la carpeta UPLOADED) - 1 
    docker cp django4u_uifs1-geo:/mnt/volumes/statics 2025_0912_1230_django_geonode_statics
    
    ó
    - cp -r /var/lib/docker/volumes/u_uifs1-geo-statics/_data 2025_0912_1218_geonode_media


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
