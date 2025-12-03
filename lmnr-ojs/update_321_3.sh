#!/bin/bash
set -e

echo "=== Iniciando tareas ==="
cd /var/www/html/Jc || exit

echo "=== Ajustar permisos a carpeta CACHE ==="
echo "Carpetas de la versión 3.2"
sudo chmod -R 777 ojs-3.2.1-3/cache
sudo chmod -R 777 ojs-3.2.1-3/public
sudo chmod -R 777 ojs-3.2.1-3/plugins


# PARA LA VERSION 3.2 REVISAR ESTO ANTES
# https://github.com/pkp/ojs/commit/47ea8dbd229829de10c7b391a72d4220776b137e

echo "=== Ajuste de permisos finalizado ==="

echo "Iniciando actualizaciones "
echo "ver ojs-3.2.1-3"  
php ojs-3.2.1-3/tools/upgrade.php upgrade


echo "Vaciando CACHE"

sudo rm -rf ojs-3.2.1-3/cache/*


echo ""
echo "= = = = = = = = = = = = = ="
echo "fin de las actualizaciones"
echo "= = = = = = = = = = = = = ="
echo ""
