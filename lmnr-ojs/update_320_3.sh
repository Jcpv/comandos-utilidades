#!/bin/bash
set -e

echo "=== Iniciando tareas ==="
cd /var/www/html/Jc || exit

echo "=== Ajustar permisos a carpeta CACHE ==="
echo "Carpetas de la versión 3.2"
sudo chmod -R 777 ojs-3.2.0-3/cache
sudo chmod -R 777 ojs-3.2.0-3/public
sudo chmod -R 777 ojs-3.2.0-3/plugins




echo "=== Ajuste de permisos finalizado ==="

echo "Iniciando actualizaciones"
echo "ver ojs-3.2.0-3"  
php ojs-3.2.0-3/tools/upgrade.php upgrade

echo ""
echo "= = = = = = = = = = = = = ="
echo "fin de las actualizaciones"
echo "= = = = = = = = = = = = = ="
echo ""
