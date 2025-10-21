
======= CONFIGURAR CERTIFICADOS SSL para contenedor NGINX =======
	CONTENEDOR=nginx4geo-atlas
	
*** CARPETA PARA CERTIFICADOS
--- Carpeta en el SERVER
	/var/lib/docker/volumes/geo-atlas-nginxcerts/_data/uifs_geo
	
--- Carpeta en el CONTENEDOR
	/geonode-certificates/uifs_geo/cimsurdomain.key;
	
*** Copiar certificados a la carpeta del SERVER
	cp /home/uifsA/ssl/* /var/lib/docker/volumes/geo-atlas-nginxcerts/_data/uifs_geo
	
	RUTA para GeoNode-UIFS
	sudo ls /var/lib/docker/volumes/u_uifs1-geo-nginxcerts/_data
	sudo mkdir /var/lib/docker/volumes/u_uifs1-geo-nginxcerts/_data/uifs_geo
	sudo cp -r ../../ssl_2025  /var/lib/docker/volumes/u_uifs1-geo-nginxcerts/_data/uifs_geo

*** Entrar al contenedor NGINX 
	docker exec -it nginx4u_uifs1-geo sh

*** ACTUALIZAR archivo CONF de NGINX
	vim nginx.https.enabled.conf
		nginx.https.available.conf // es el mismo que en anterior


	server {
	    listen              443 ssl;
	    server_name         atlaschiapas.cimsur.unam.mx;
	    keepalive_timeout   70;

	    # ssl_certificate     /certificate_symlink/fullchain.pem;
	    # ssl_certificate_key /certificate_symlink/privkey.pem;
			ssl_certificate /geonode-certificates/uifs_geo/bundle.crt;
			ssl_certificate_key /geonode-certificates/uifs_geo/cimsurdomain.key;

	    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
	    ssl_ciphers         HIGH:!aNULL:!MD5;

	    include sites-enabled/*.conf;
	}

*** RECARGAR la configuración de Nginx: 
		nginx -s reload



--------------------------------------------------------------------------------
- - - - - Conocer la Version de GEONODE
--------------------------------------------------------------------------------
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


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--------   C U I D A D O - ELIMINA VOLUMENES --- ----- ----- ----- ---- ---- 
---------------------------------------------------------------------------------

docker volume rm  u_uifs1-geo-backup-restore u_uifs1-geo-data u_uifs1-geo-dbbackups u_uifs1-geo-dbdata u_uifs1-geo-gsdatadir u_uifs1-geo-nginxcerts u_uifs1-geo-nginxconfd u_uifs1-geo-rabbitmq u_uifs1-geo-statics u_uifs1-geo-tmp

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

 

 --------------------------------------------------------------------------------======= REVISAR PUERTO DE CONTENEDOR - NGINX =======
---------------------------------------------------------------------------------

	sudo lsof -i -P -n
	nmap -sT -O localhost


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


