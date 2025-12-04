#!/bin/bash
set -e

echo "=== Iniciando tareas ==="

lmnr-ojs/./php_version.sh

echo "=== Continuando con el proceso de actualizacion  ==="


cd /home/jc/Escritorio/Jc-Lmnr || exit

# --- CONFIGURACIÓN DE MYSQL ---
MYSQL_USER="root"
MYSQL_PASS="Pruebas1234"
MYSQL_HOST="localhost"

# Nombre de base de datos a crear o eliminar
DB_NAME="ojs_demo"
DB_NAME_AGREGAR="2025_1204_0935_ojs_lmnr_3.3.0.21.ok.sql"

echo "Conectando a MySQL..."

echo "Eliminando base de datos $DB_NAME (si existe)..."
mysql -u$MYSQL_USER -p$MYSQL_PASS -h$MYSQL_HOST -e "DROP DATABASE IF EXISTS \`$DB_NAME\`;"

# --- Ejemplo: crear la base de datos ---
echo "Creando base de datos $DB_NAME..."
mysql -u$MYSQL_USER -p$MYSQL_PASS -h$MYSQL_HOST -e "CREATE DATABASE \`$DB_NAME\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

echo "Base de datos creada correctamente."

# --- Ejemplo: ejecutar un archivo SQL ---
echo "Importando DATOS"
mysql -u$MYSQL_USER -p$MYSQL_PASS -h$MYSQL_HOST $DB_NAME < $DB_NAME_AGREGAR

echo "Fin de importar datos estructura..."

# ------------------------------------------------
echo ">>> Corrigiendo tablas que no son InnoDB... REQUERIDO PARA LA 3.4"

sudo mysql -u$MYSQL_USER -p$MYSQL_PASS -e "
SET FOREIGN_KEY_CHECKS=0;
SELECT CONCAT('ALTER TABLE \`', TABLE_NAME, '\` ENGINE=InnoDB;') 
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA='$DB_NAME' 
AND ENGINE!='InnoDB';
" > /tmp/convert_innodb2.sql

echo ">>> Ejecutando conversiones..."
mysql -u$MYSQL_USER -p$MYSQL_PASS $DB_NAME < /tmp/convert_innodb.sql

mysql -u$MYSQL_USER -p$MYSQL_PASS -e "SET FOREIGN_KEY_CHECKS=1;"

echo ">>> Todas las tablas ahora deberían ser InnoDB."

echo ">>> Limpiando cache..."
rm -rf cache/*.php cache/t_compile/* cache/t_cache/* cache/_db/* 2>/dev/null
# ------------------------------------------------

echo "- - - - - - - - "
echo "MySQL listo."
echo "- - - - - - - - "

echo "REGRESANDO A LA CARPETA DE INSTALACION"
cd /var/www/html/Jc || exit

echo "=== Ajustar permisos a carpeta CACHE ==="
echo "Carpetas de la versión 3.3"

chown -R jc:jc ojs-3.4.0-0
sudo chmod -R 777 ojs-3.4.0-0/cache
sudo chmod -R 777 ojs-3.4.0-0/public
sudo chmod -R 777 ojs-3.4.0-0/plugins

sudo chmod -R 777 ojs-3.4.0-1/cache
sudo chmod -R 777 ojs-3.4.0-1/public
sudo chmod -R 777 ojs-3.4.0-1/plugins

sudo chmod -R 777 ojs-3.4.0-2/cache
sudo chmod -R 777 ojs-3.4.0-2/public
sudo chmod -R 777 ojs-3.4.0-2/plugins

chown -R jc:jc ojs-3.4.0-3
sudo chmod -R 777 ojs-3.4.0-3/cache
sudo chmod -R 777 ojs-3.4.0-3/public
sudo chmod -R 777 ojs-3.4.0-3/plugins

chown -R jc:jc ojs-3.4.0-4
sudo chmod -R 777 ojs-3.4.0-4/cache
sudo chmod -R 777 ojs-3.4.0-4/public
sudo chmod -R 777 ojs-3.4.0-4/plugins

chown -R jc:jc ojs-3.4.0-5
sudo chmod -R 777 ojs-3.4.0-5/cache
sudo chmod -R 777 ojs-3.4.0-5/public
sudo chmod -R 777 ojs-3.4.0-5/plugins

chown -R jc:jc ojs-3.4.0-6
sudo chmod -R 777 ojs-3.4.0-6/cache
sudo chmod -R 777 ojs-3.4.0-6/public
sudo chmod -R 777 ojs-3.4.0-6/plugins

chown -R jc:jc ojs-3.4.0-7
sudo chmod -R 777 ojs-3.4.0-7/cache
sudo chmod -R 777 ojs-3.4.0-7/public
sudo chmod -R 777 ojs-3.4.0-7/plugins

chown -R jc:jc ojs-3.4.0-8
sudo chmod -R 777 ojs-3.4.0-8/cache
sudo chmod -R 777 ojs-3.4.0-8/public
sudo chmod -R 777 ojs-3.4.0-8/plugins

chown -R jc:jc ojs-3.4.0-9
sudo chmod -R 777 ojs-3.4.0-9/cache
sudo chmod -R 777 ojs-3.4.0-9/public
sudo chmod -R 777 ojs-3.4.0-9/plugins

echo "=== Ajuste de permisos finalizado ==="

echo "Iniciando actualizaciones"
echo "ver ojs 3.4.... <----"  
#php ojs-3.4.0/tools/upgrade.php upgrade  * ESTA NO AVANZA MARCA ERROR
php ojs-3.4.0-0/tools/upgrade.php upgrade &&
php ojs-3.4.0-1/tools/upgrade.php upgrade &&
php ojs-3.4.0-2/tools/upgrade.php upgrade &&
php ojs-3.4.0-3/tools/upgrade.php upgrade &&
php ojs-3.4.0-4/tools/upgrade.php upgrade &&
php ojs-3.4.0-5/tools/upgrade.php upgrade &&

## APARTIR DE LA 6 REQUIERE AJUSTES DE CAMPOS EN LA BASE DE DATOS

#  UPDATE submissions 
#  SET submission_progress = 1 
#  WHERE submission_progress REGEXP '[^0-9]';

#  UPDATE submissions 
#  SET submission_progress = 1 
#  WHERE submission_progress IS NULL OR submission_progress = '';

#  ALTER TABLE submissions  
#  MODIFY COLUMN submission_progress TINYINT NOT NULL DEFAULT 1;


#php ojs-3.4.0-6/tools/upgrade.php upgrade &&
#php ojs-3.4.0-7/tools/upgrade.php upgrade &&
#php ojs-3.4.0-8/tools/upgrade.php upgrade &&
#php ojs-3.4.0-9/tools/upgrade.php upgrade 

echo "Vaciando CACHE"

sudo rm -rf ojs-3.4.0-0/cache/*
sudo rm -rf ojs-3.4.0-1/cache/*
sudo rm -rf ojs-3.4.0-2/cache/*
sudo rm -rf ojs-3.4.0-3/cache/*
sudo rm -rf ojs-3.4.0-4/cache/*
sudo rm -rf ojs-3.4.0-5/cache/*
sudo rm -rf ojs-3.4.0-6/cache/*
sudo rm -rf ojs-3.4.0-7/cache/*
sudo rm -rf ojs-3.4.0-8/cache/*
sudo rm -rf ojs-3.4.0-9/cache/*

echo ""
echo "= = = = = = = = = = = = = ="
echo "fin de las actualizaciones"
echo "= = = = = = = = = = = = = ="
echo ""
