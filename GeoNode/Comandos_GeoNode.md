======= PASOS PARA CREAR EL CONTENEDOR=======
*** Crear archivo .ENV con parametros del sitio ***
	python3 create-envfile.py --hostname 186.96.43.9:8084 --geonodepwd admin --geoserverpwd geoserver




*** Modificar archivos de GEONODE ***
	nano Dockerfile
	nano .env
	nano docker-compose.yml


*** Construye archivo de geoNode, según los parametros indicados previamente ***
	docker-compose build
	docker-compose up -d 


	docker-compose start 
	docker-compose restart
	docker-compose down


	docker volume ls


======= ELLIMINAR VOLUMENES creados con docker =======
	docker volume rm u_uifs-geo-data u_uifs-geo-dbbackups u_uifs-geo-backup-restore u_uifs-geo-nginxcerts u_uifs-geo-dbdata u_uifs-geo-tmp u_uifs-geo-nginxconfd u_uifs-geo-statics u_uifs-geo-gsdatadir u_uifs-geo-rabbitmq 




	docker volume rm u_uifs2-geo-data u_uifs2-geo-dbbackups u_uifs2-geo-backup-restore u_uifs2-geo-nginxcerts u_uifs2-geo-dbdata u_uifs2-geo-tmp u_uifs2-geo-nginxconfd u_uifs2-geo-statics u_uifs2-geo-gsdatadir u_uifs2-geo-rabbitmq 




	docker volume rm geonode-data geonode-dbbackups geonode-backup-restore 	geonode-nginxcerts geonode-dbdata geonode-tmp geonode-nginxconfd geonode-statics geonode-gsdatadir geonode-rabbitmq 




	docker volume rm geo-atlas-data geo-atlas-dbbackups geo-atlas-backup-restore geo-atlas-nginxcerts geo-atlas-dbdata geo-atlas-tmp geo-atlas-nginxconfd geo-atlas-statics geo-atlas-gsdatadir geo-atlas-rabbitmq 




======= REVISAR PUERTO DE CONTENEDOR - NGINX =======
	sudo lsof -i -P -n
	nmap -sT -O localhost


*** PARA ENTRAR AL CONTENEDOR NGINX
	docker exec -it nginx4 sh


*** 1. archivos a modificar
	vim /docker-entrypoint.sh
	vim sites-enabled/geonode.conf.envsubst


*** 2. Ajustar parametros 
	https://github.com/GeoNode/geonode-docker/pull/53/files
	if [ -z "${HTTPS_HOST}" ]; then
			HTTP_SCHEME="http"
			if [ $HTTP_PORT = "80" ]; then
				PUBLIC_HOST=${HTTP_HOST}
			else
				PUBLIC_HOST="$HTTP_HOST:$HTTP_PORT"
			fi
	else
			HTTP_SCHEME="https"
			if [ $HTTPS_PORT = "443" ]; then
				PUBLIC_HOST=${HTTPS_HOST}
			else
				PUBLIC_HOST="$HTTPS_HOST:$HTTPS_PORT"
			fi
	fi
		
		export PUBLIC_HOST=${PUBLIC_HOST}
		
		- - - -
		proxy_set_header            Host $PUBLIC_HOST;
	  	proxy_set_header            Origin $HTTP_SCHEME://$PUBLIC_HOST;
 
 
*** 3. Volver a CARGAR la configuración de Nginx: 
	nginx -s reload






======= CONFIGURAR CERTIFICADOS SSL para contenedor NGINX =======
	CONTENEDOR=nginx4geo-atlas
	
*** CARPETA PARA CERTIFICADOS
--- Carpeta en el SERVER
	/var/lib/docker/volumes/geo-atlas-nginxcerts/_data/my_geonode
	
--- Carpeta en el CONTENEDOR
	/geonode-certificates/my_geonode/cimsurdomain.key;
	
*** Copiar certificados a la carpeta del SERVER
	cp /home/uifsA/ssl/* /var/lib/docker/volumes/geo-atlas-nginxcerts/_data/my_geonode
	
	RUTA para GeoNode-UIFS
	sudo ls /var/lib/docker/volumes/u_uifs1-geo-nginxcerts/_data/uifs_geo


*** Entrar al contenedor NGINX 
	docker-compose exec geonode sh
	docker exec -it nginx4 sh
	docker exec -it nginx4u_uifs1-geo sh



*** ACTUALIZAR archivo CONF de NGINX
	vim nginx.https.enabled.conf


	server {
	    listen              443 ssl;
	    server_name         atlaschiapas.cimsur.unam.mx;
	    keepalive_timeout   70;


	    # ssl_certificate     /certificate_symlink/fullchain.pem;
	    # ssl_certificate_key /certificate_symlink/privkey.pem;
	    ssl_certificate /geonode-certificates/uifs_geo/ssl_2025/bundle.crt;
	    ssl_certificate_key /geonode-certificates/uifs_geo/ssl_2025/cimsurdomain.key;



	    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
	    ssl_ciphers         HIGH:!aNULL:!MD5;


	    include sites-enabled/*.conf;
	}


*** RECARGAR la configuración de Nginx: 
		nginx -s reload




======= PASOS PARA REALIZAR RESPALDO DEL CONTENEDOR DOCKER =======


*** 1 . entrar al contenedor docker
	docker exec -it django4geonode /bin/bash
  
*** 2. Ejecutar el comando
	python manage.py backup --backup-dir=/backup_restore --config=/backup_restore/settings.ini 
  
*** 3. Ver el contenido de la carpeta -backup_restore-
	ls /backup_restore


*** 4. Salir del contendor
	exit


*** 5. Buscar el archivo creado  (esto llevara a la carpeta del volumen del contenedor)
  find / -name 2025-03-17_185245.md5


*** Mover los archivos creados en la carpeta del contenedor a mi carpeta de respaldo  
mv /var/lib/docker/volumes/geonode-backup-restore/_data/2025-03-17_185245.* /home/resp_geonode
(.ini , .zip y .md5)
 




======= RESTAURAR RESPALDO GEONODE =======
*** carpeta VOLUMES en el SERVER
	/var/lib/docker/volumes/geo-atlas-backup-restore/_data


*** COPIAR archivos de respaldo a la carpeta VOLUMES del SERVER 
	cp /home/uifsA/migracion/2025* /var/lib/docker/volumes/geo-atlas-backup-restore/_data




*** ENTRAR AL CONTENEDOR DJANGO 
	docker exec -it django4geo-atlas /bin/bash
	python manage.py restore --backup-file=/backup_restore/2025-04-22_005023.zip --config=/backup_restore/2025-04-22_005023.ini
























cd /var/lib/docker/volumes/u_uifs-atlas-nginxconfd/_data
nano nginx.https.available.conf.envsubst






su postgres




/var/lib/docker/volumes/u_uifs-atlas-gsdatadir/_data/workspaces/geonode/styles


/var/lib/docker/volumes/u_uifs-atlas-gsdatadir/_data/workspaces/geonode/geonode_data




Mv geonode_data/* .






ID DE RESPALDO 
<id>DataStoreInfoImpl-566da7a1:196823d187f:-8000</id>






python manage.py updatelayers


