#!/bin/bash
set -e

echo "=== Iniciando tareas ==="
cd /var/www/html/Jc || exit

echo "=== Ajustar permisos a carpeta CACHE ==="
echo "Carpetas de la versión 3.1.2"
sudo chmod -R 777 ojs-3.1.2-2/cache
sudo chmod -R 777 ojs-3.1.2-2/public
sudo chmod -R 777 ojs-3.1.2-2/plugins

sudo chmod -R 777 ojs-3.1.2-3/cache
sudo chmod -R 777 ojs-3.1.2-3/public
sudo chmod -R 777 ojs-3.1.2-3/plugins

sudo chmod -R 777 ojs-3.1.2-4/cache
sudo chmod -R 777 ojs-3.1.2-4/public
sudo chmod -R 777 ojs-3.1.2-4/plugins


echo "=== Ajuste de permisos finalizado ==="

echo "Iniciando actualizaciones"
echo "ver ojs 3.1"  
php ojs-3.1.2-2/tools/upgrade.php upgrade && 
php ojs-3.1.2-3/tools/upgrade.php upgrade &&
php ojs-3.1.2-4/tools/upgrade.php upgrade &&


echo "Vaciando CACHE"

sudo rm -rf ojs-3.1.2-2/cache/*
sudo rm -rf ojs-3.1.2-3/cache/*
sudo rm -rf ojs-3.1.2-4/cache/*

echo ""
echo "= = = = = = = = = = = = = ="
echo "fin de las actualizaciones"
echo "= = = = = = = = = = = = = ="
echo ""
