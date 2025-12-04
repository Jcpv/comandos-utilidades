#!/bin/bash
set -e

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

echo "- - - - - - - - "
echo "MySQL listo."
echo "- - - - - - - - "

# SE NECESITA REGRESAR A LA CARPETA DE INSTALACION
# echo "REGRESANDO A LA CARPETA DE INSTALACION"
# cd /var/www/html/Jc || exit
