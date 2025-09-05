


✅ Paso 1: Respaldo de la base de datos (PostgreSQL/PostGIS)

docker exec -t db pg_dump -U geonode -d geonode > geonode_backup.sql
docker exec -t db pg_dump -U geonode_data -d geonode_data > geonode_data_backup.sql

--EN MI CONTENEDOR
docker exec -t db4u_uifs1-geo pg_dump -U geonode -d geonode > geonode_backup.sql
docker exec -t db4u_uifs1-geo pg_dump -U geonode_data -d geonode_data > 2025_0905_1107_geonode_data_backup.sql

 
✅ Paso 2: Respaldo de la configuración y datos de GeoServer
Busca el volumen de datos de GeoServer. Generalmente es algo como /geoserver_data dentro del contenedor. Para copiarlo al host:

docker cp geoserver:/geoserver_data ./backup/geoserver_data


--EN MI CONTENEDOR
docker cp geoserver4u_uifs1-geo:/geoserver_data 2025_0905_1107_geoserver_data


✅ Paso 3: Respaldar archivos subidos a GeoNode (media)
Por ejemplo:

docker cp django:/mnt/volumes/statics ./backup/geonode_statics


--EN MI CONTENEDOR
docker cp django4u_uifs1-geo:/mnt/volumes/static 2025_0905_1107_django_geonode_static


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







