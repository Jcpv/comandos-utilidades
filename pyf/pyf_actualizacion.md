****
# Para ejecutar la actualización es importante poner el sistema con la siguiente variable en - off -
installed = Off

# Pasos para ejecutar el scrip de tareas
chmod +x tareas_up_pyf.sh
./tareas_up_pyf.sh

# Cargar la Base de datos
mysql -u root -p ojs_pyf < 2025_1029_1158_Ojs33011.sql



# Buscar el archivo --- usageStats.xml --- 
Si el archivo no existe (en OJS 3.4+)

En OJS 3.4.x, algunos plugins se movieron.
La nueva ruta puede ser:
    plugins/generic/usageStats/scheduledTasks.xml

Comando:
    php tools/runScheduledTasks.php plugins/generic/usageStats/scheduledTasks.xml

Verificar cuál existe con:
    find /var/www/html/pyf/ojs-3.4.0-0 -name "scheduledTasks.xml"

Si da error de permisos: Asegúrate de que el usuario con el que corres PHP (por ejemplo www-data o tu usuario) tenga acceso de lectura:
    sudo chown -R www-data:www-data /var/www/html/pyf/
    sudo chmod -R 755 /var/www/html/pyf/


# Revisar estas tareas 
cd /var/www/html/pyf/FilesOjsPyf/usageStats
ls reject processing stage

Si alguno de esos tiene archivos .log, .tmp o .xml, OJS se niega a continuar la actualización.

# Si los logs no son importantes (solución rápida)
Puedes moverlos al archivo o eliminarlos (solo afectará las estadísticas de visitas antiguas, no los artículos ni usuarios).
    mv reject/* archive/ 2>/dev/null
    mv processing/* archive/ 2>/dev/null
    mv stage/* archive/ 2>/dev/null




# Al terminar de actualizar es importante borrar la cache
    cd /var/www/html/pyf/ojs-3.4.0-9

    rm -rf cache/t_compile/*
    rm -rf cache/_db/*
    rm -rf cache/fc-*

Luego borra también los archivos de caché que empiecen con fc-:
    rm -f cache/fc-*

Que el usuario del servidor web (por ejemplo, www-data) tenga acceso:
    sudo chown -R www-data:www-data cache/ public/ ../FilesOjsPyf/

    sudo chmod -R 755 /var/www/html/pyf/FilesOjsPyf


# Ejecuta la reconstrucción de índices desde terminal:
    cd /var/www/html/pyf/ojs-3.4.0-9
    php tools/rebuildSearchIndex.php

    👉 El comando puede tardar varios minutos según la cantidad de artículos, pero acelera mucho las páginas de detalle.


### OTRAS COSAS 
Caché del template y base de datos
La primera carga de una página de artículo reconstruye varias cachés internas (plantillas, consultas, etc.).
Después de limpiar cache/t_compile/ y cache/_db/, la primera carga será lenta, pero luego debe mejorar.

Si sigue igual, activa la caché de base de datos en config.inc.php:
    [cache]
    cache = apc

O, si no tienes APC, usa:
    cache = file


🧱 Configura correctamente PHP y la base de datos 
Verifica el php.ini:
    memory_limit = 512M
    max_execution_time = 120
    upload_max_filesize = 50M
    post_max_size = 50M


🧱 Limpia y optimiza la base de datos
    mysqlcheck -u root -p --auto-repair --optimize ojs_pyf

    OPTIMIZE TABLE submission_files, metrics, submission_file_settings, publication_settings;

    php tools/rebuildSearchIndex.php

 🧱 Reconstruir índices de búsqueda
    Esto puede tardar varios minutos dependiendo de la cantidad de artículos.



En config.inc.php asegúrate de tener:
    [general]
    installed = On
    show_upgrade_warning = Off
    enable_cdn = On
    minify = On

    [cache]
    cache = file
    web_cache = On




# Ver el log de PHP
    sudo tail -n 20 /var/log/apache2/error.log


