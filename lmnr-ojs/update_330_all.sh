#!/bin/bash
set -e

echo "=== Iniciando tareas ==="

lmnr-ojs/./php_version.sh

cd /home/jc/Escritorio/Jc-Lmnr || exit

# --- CONFIGURACIÓN DE MYSQL ---
MYSQL_USER="root"
MYSQL_PASS="Pruebas1234"
MYSQL_HOST="localhost"

# Nombre de base de datos a crear o eliminar
DB_NAME="ojs_demo"
DB_NAME_AGREGAR="2025_1203_1429_ojs_lmnr_3.2.1.5.ok.sql"

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

echo "- - - - - - - - "
echo "MySQL listo."
echo "- - - - - - - - "

echo "REGRESANDO A LA CARPETA DE INSTALACION"
cd /var/www/html/Jc || exit

echo "=== Ajustar permisos a carpeta CACHE ==="
echo "Carpetas de la versión 3.3"

chown -R jc:jc ojs-3.3.0
sudo chmod -R 777 ojs-3.3.0/cache
sudo chmod -R 777 ojs-3.3.0/public
sudo chmod -R 777 ojs-3.3.0/plugins

#sudo chmod -R 777 ojs-3.3.0-1/cache
#sudo chmod -R 777 ojs-3.3.0-1/public
#sudo chmod -R 777 ojs-3.3.0-1/plugins

#sudo chmod -R 777 ojs-3.3.0-2/cache
#sudo chmod -R 777 ojs-3.3.0-2/public
#sudo chmod -R 777 ojs-3.3.0-2/plugins

chown -R jc:jc ojs-3.3.0-3
sudo chmod -R 777 ojs-3.3.0-3/cache
sudo chmod -R 777 ojs-3.3.0-3/public
sudo chmod -R 777 ojs-3.3.0-3/plugins

chown -R jc:jc ojs-3.3.0-4
sudo chmod -R 777 ojs-3.3.0-4/cache
sudo chmod -R 777 ojs-3.3.0-4/public
sudo chmod -R 777 ojs-3.3.0-4/plugins

chown -R jc:jc ojs-3.3.0-5
sudo chmod -R 777 ojs-3.3.0-5/cache
sudo chmod -R 777 ojs-3.3.0-5/public
sudo chmod -R 777 ojs-3.3.0-5/plugins

chown -R jc:jc ojs-3.3.0-6
sudo chmod -R 777 ojs-3.3.0-6/cache
sudo chmod -R 777 ojs-3.3.0-6/public
sudo chmod -R 777 ojs-3.3.0-6/plugins

chown -R jc:jc ojs-3.3.0-7
sudo chmod -R 777 ojs-3.3.0-7/cache
sudo chmod -R 777 ojs-3.3.0-7/public
sudo chmod -R 777 ojs-3.3.0-7/plugins

chown -R jc:jc ojs-3.3.0-8
sudo chmod -R 777 ojs-3.3.0-8/cache
sudo chmod -R 777 ojs-3.3.0-8/public
sudo chmod -R 777 ojs-3.3.0-8/plugins

chown -R jc:jc ojs-3.3.0-9
sudo chmod -R 777 ojs-3.3.0-9/cache
sudo chmod -R 777 ojs-3.3.0-9/public
sudo chmod -R 777 ojs-3.3.0-9/plugins

chown -R jc:jc ojs-3.3.0-10
sudo chmod -R 777 ojs-3.3.0-10/cache
sudo chmod -R 777 ojs-3.3.0-10/public
sudo chmod -R 777 ojs-3.3.0-10/plugins

chown -R jc:jc ojs-3.3.0-11
sudo chmod -R 777 ojs-3.3.0-11/cache
sudo chmod -R 777 ojs-3.3.0-11/public
sudo chmod -R 777 ojs-3.3.0-11/plugins

chown -R jc:jc ojs-3.3.0-12
sudo chmod -R 777 ojs-3.3.0-12/cache
sudo chmod -R 777 ojs-3.3.0-12/public
sudo chmod -R 777 ojs-3.3.0-12/plugins

chown -R jc:jc ojs-3.3.0-13
sudo chmod -R 777 ojs-3.3.0-13/cache
sudo chmod -R 777 ojs-3.3.0-13/public
sudo chmod -R 777 ojs-3.3.0-13/plugins

chown -R jc:jc ojs-3.3.0-14
sudo chmod -R 777 ojs-3.3.0-14/cache
sudo chmod -R 777 ojs-3.3.0-14/public
sudo chmod -R 777 ojs-3.3.0-14/plugins

chown -R jc:jc ojs-3.3.0-15
sudo chmod -R 777 ojs-3.3.0-15/cache
sudo chmod -R 777 ojs-3.3.0-15/public
sudo chmod -R 777 ojs-3.3.0-15/plugins

chown -R jc:jc ojs-3.3.0-16
sudo chmod -R 777 ojs-3.3.0-16/cache
sudo chmod -R 777 ojs-3.3.0-16/public
sudo chmod -R 777 ojs-3.3.0-16/plugins

chown -R jc:jc ojs-3.3.0-17
sudo chmod -R 777 ojs-3.3.0-17/cache
sudo chmod -R 777 ojs-3.3.0-17/public
sudo chmod -R 777 ojs-3.3.0-17/plugins

chown -R jc:jc ojs-3.3.0-18
sudo chmod -R 777 ojs-3.3.0-18/cache
sudo chmod -R 777 ojs-3.3.0-18/public
sudo chmod -R 777 ojs-3.3.0-18/plugins

chown -R jc:jc ojs-3.3.0-19
sudo chmod -R 777 ojs-3.3.0-19/cache
sudo chmod -R 777 ojs-3.3.0-19/public
sudo chmod -R 777 ojs-3.3.0-19/plugins

chown -R jc:jc ojs-3.3.0-20
sudo chmod -R 777 ojs-3.3.0-20/cache
sudo chmod -R 777 ojs-3.3.0-20/public
sudo chmod -R 777 ojs-3.3.0-20/plugins

chown -R jc:jc ojs-3.3.0-21
sudo chmod -R 777 ojs-3.3.0-21/cache
sudo chmod -R 777 ojs-3.3.0-21/public
sudo chmod -R 777 ojs-3.3.0-21/plugins

echo "=== Ajuste de permisos finalizado ==="

echo "Iniciando actualizaciones"
echo "ver ojs 3.3.... <----"  
#php ojs-3.3.0/tools/upgrade.php upgrade  * ESTA NO AVANZA MARCA ERROR
php ojs-3.3.0-3/tools/upgrade.php upgrade &&
php ojs-3.3.0-4/tools/upgrade.php upgrade &&
php ojs-3.3.0-5/tools/upgrade.php upgrade &&
php ojs-3.3.0-6/tools/upgrade.php upgrade &&
php ojs-3.3.0-7/tools/upgrade.php upgrade &&
php ojs-3.3.0-8/tools/upgrade.php upgrade &&
php ojs-3.3.0-9/tools/upgrade.php upgrade &&
php ojs-3.3.0-10/tools/upgrade.php upgrade &&
php ojs-3.3.0-11/tools/upgrade.php upgrade &&
php ojs-3.3.0-12/tools/upgrade.php upgrade &&
php ojs-3.3.0-13/tools/upgrade.php upgrade &&
php ojs-3.3.0-14/tools/upgrade.php upgrade &&
php ojs-3.3.0-15/tools/upgrade.php upgrade &&
php ojs-3.3.0-16/tools/upgrade.php upgrade &&
php ojs-3.3.0-17/tools/upgrade.php upgrade &&
php ojs-3.3.0-18/tools/upgrade.php upgrade &&
php ojs-3.3.0-19/tools/upgrade.php upgrade &&
php ojs-3.3.0-20/tools/upgrade.php upgrade &&
php ojs-3.3.0-21/tools/upgrade.php upgrade 


echo "Vaciando CACHE"

sudo rm -rf ojs-3.3.0/cache/*
#sudo rm -rf ojs-3.3.0-1/cache/*
#sudo rm -rf ojs-3.3.0-2/cache/*
sudo rm -rf ojs-3.3.0-3/cache/*
sudo rm -rf ojs-3.3.0-4/cache/*
sudo rm -rf ojs-3.3.0-5/cache/*
sudo rm -rf ojs-3.3.0-6/cache/*
sudo rm -rf ojs-3.3.0-7/cache/*
sudo rm -rf ojs-3.3.0-8/cache/*
sudo rm -rf ojs-3.3.0-9/cache/*
sudo rm -rf ojs-3.3.0-10/cache/*
sudo rm -rf ojs-3.3.0-11/cache/*
sudo rm -rf ojs-3.3.0-12/cache/*
sudo rm -rf ojs-3.3.0-13/cache/*
sudo rm -rf ojs-3.3.0-14/cache/*
sudo rm -rf ojs-3.3.0-15/cache/*
sudo rm -rf ojs-3.3.0-16/cache/*
sudo rm -rf ojs-3.3.0-17/cache/*
sudo rm -rf ojs-3.3.0-18/cache/*
sudo rm -rf ojs-3.3.0-19/cache/*
sudo rm -rf ojs-3.3.0-20/cache/*
sudo rm -rf ojs-3.3.0-21/cache/*


echo ""
echo "= = = = = = = = = = = = = ="
echo "fin de las actualizaciones"
echo "= = = = = = = = = = = = = ="
echo ""
