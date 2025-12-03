#!/bin/bash
set -e

echo "=== Iniciando tareas ==="
cd /var/www/html/Jc || exit

echo "=== Ajustar permisos a carpeta CACHE ==="
echo "Carpetas de la versión 3.2"

# 3.2.1.0
sudo chmod -R 777 ojs-3.2.1/cache
sudo chmod -R 777 ojs-3.2.1/public
sudo chmod -R 777 ojs-3.2.1/plugins

sudo chmod -R 777 ojs-3.2.1-1/cache
sudo chmod -R 777 ojs-3.2.1-1/public
sudo chmod -R 777 ojs-3.2.1-1/plugins

sudo chmod -R 777 ojs-3.2.1-2/cache
sudo chmod -R 777 ojs-3.2.1-2/public
sudo chmod -R 777 ojs-3.2.1-2/plugins

sudo chmod -R 777 ojs-3.2.1-3/cache
sudo chmod -R 777 ojs-3.2.1-3/public
sudo chmod -R 777 ojs-3.2.1-3/plugins

sudo chmod -R 777 ojs-3.2.1-4/cache
sudo chmod -R 777 ojs-3.2.1-4/public
sudo chmod -R 777 ojs-3.2.1-4/plugins

sudo chmod -R 777 ojs-3.2.1-5/cache
sudo chmod -R 777 ojs-3.2.1-5/public
sudo chmod -R 777 ojs-3.2.1-5/plugins


echo "=== Ajuste de permisos finalizado ==="

echo "Iniciando actualizaciones"
echo "ver ojs 3.2.... <----"  
php ojs-3.2.1/tools/upgrade.php upgrade  &&
php ojs-3.2.1-1/tools/upgrade.php upgrade &&
php ojs-3.2.1-2/tools/upgrade.php upgrade &&
php ojs-3.2.1-3/tools/upgrade.php upgrade &&
php ojs-3.2.1-4/tools/upgrade.php upgrade &&
php ojs-3.2.1-5/tools/upgrade.php upgrade


echo "Vaciando CACHE"

sudo rm -rf ojs-3.2.1/cache/*
sudo rm -rf ojs-3.2.1-1/cache/*
sudo rm -rf ojs-3.2.1-2/cache/*
sudo rm -rf ojs-3.2.1-3/cache/*
sudo rm -rf ojs-3.2.1-4/cache/*
sudo rm -rf ojs-3.2.1-5/cache/*

echo ""
echo "= = = = = = = = = = = = = ="
echo "fin de las actualizaciones"
echo "= = = = = = = = = = = = = ="
echo ""
