#!/bin/bash
set -e

echo "=== Iniciando tareas ==="
cd /var/www/html/Jc || exit

echo "=== Ajustar permisos a carpeta CACHE ==="
echo "Carpetas de la versión 3.2"
sudo chmod -R 777 ojs-3.2.0-1/cache
sudo chmod -R 777 ojs-3.2.0-1/public
sudo chmod -R 777 ojs-3.2.0-1/plugins




echo "=== Ajuste de permisos finalizado ==="

echo "Iniciando actualizaciones"
echo "ver ojs-3.2.0-1"  
php ojs-3.2.0-1/tools/upgrade.php upgrade

echo ""
echo "= = = = = = = = = = = = = ="
echo "fin de las actualizaciones"
echo "= = = = = = = = = = = = = ="
echo ""
