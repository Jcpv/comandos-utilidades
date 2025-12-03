echo "=== Iniciando tareas ==="
cd /var/www/html/Jc || exit

echo "=== Ajustar permisos a carpeta CACHE ==="
echo "Carpetas de la versión 3.3"
sudo chmod -R 777 ojs-3.3.0-12/cache
sudo chmod -R 777 ojs-3.3.0-13/cache
sudo chmod -R 777 ojs-3.3.0-14/cache
sudo chmod -R 777 ojs-3.3.0-15/cache
sudo chmod -R 777 ojs-3.3.0-16/cache
sudo chmod -R 777 ojs-3.3.0-17/cache
sudo chmod -R 777 ojs-3.3.0-18/cache
sudo chmod -R 777 ojs-3.3.0-19/cache
sudo chmod -R 777 ojs-3.3.0-20/cache
sudo chmod -R 777 ojs-3.3.0-21/cache

echo "Carpetas de la versión 3.4"
sudo chmod -R 777 ojs-3.4.0-0/cache
sudo chmod -R 777 ojs-3.4.0-1/cache
sudo chmod -R 777 ojs-3.4.0-2/cache
sudo chmod -R 777 ojs-3.4.0-3/cache
sudo chmod -R 777 ojs-3.4.0-4/cache
sudo chmod -R 777 ojs-3.4.0-5/cache
sudo chmod -R 777 ojs-3.4.0-6/cache
sudo chmod -R 777 ojs-3.4.0-7/cache
sudo chmod -R 777 ojs-3.4.0-8/cache
sudo chmod -R 777 ojs-3.4.0-9/cache

sudo chmod -R 777 ojs-3.4.0-0/public
sudo chmod -R 777 ojs-3.4.0-1/public
sudo chmod -R 777 ojs-3.4.0-2/public
sudo chmod -R 777 ojs-3.4.0-3/public
sudo chmod -R 777 ojs-3.4.0-4/public
sudo chmod -R 777 ojs-3.4.0-5/public
sudo chmod -R 777 ojs-3.4.0-6/public
sudo chmod -R 777 ojs-3.4.0-7/public
sudo chmod -R 777 ojs-3.4.0-8/public
sudo chmod -R 777 ojs-3.4.0-9/public

sudo chmod -R 777 ojs-3.4.0-0/plugins
sudo chmod -R 777 ojs-3.4.0-1/plugins
sudo chmod -R 777 ojs-3.4.0-2/plugins
sudo chmod -R 777 ojs-3.4.0-3/plugins
sudo chmod -R 777 ojs-3.4.0-4/plugins
sudo chmod -R 777 ojs-3.4.0-5/plugins
sudo chmod -R 777 ojs-3.4.0-6/plugins
sudo chmod -R 777 ojs-3.4.0-7/plugins
sudo chmod -R 777 ojs-3.4.0-8/plugins
sudo chmod -R 777 ojs-3.4.0-9/plugins


echo "=== Ajuste de permisos finalizado ==="

echo "Iniciando actualizaciones"
echo "ver 3.3.0-12"  
php ojs-3.3.0-12/tools/upgrade.php upgrade

echo "----> ver 3.3.0-13"  
php ojs-3.3.0-13/tools/upgrade.php upgrade

echo "----> ver 3.3.0-14"  
php ojs-3.3.0-14/tools/upgrade.php upgrade

echo "----> ver 3.3.0-15"  
php ojs-3.3.0-15/tools/upgrade.php upgrade

echo "----> ver 3.3.0-16"  
php ojs-3.3.0-16/tools/upgrade.php upgrade

echo "----> ver 3.3.0-17"  
php ojs-3.3.0-17/tools/upgrade.php upgrade

echo "----> ver 3.3.0-18"  
php ojs-3.3.0-18/tools/upgrade.php upgrade

echo "----> ver 3.3.0-19"
php ojs-3.3.0-19/tools/upgrade.php upgrade

echo "----> ver 3.3.0-20"
php ojs-3.3.0-20/tools/upgrade.php upgrade

echo "----> ver 3.3.0-21"
php ojs-3.3.0-21/tools/upgrade.php upgrade

echo ""
echo "--------------------------------"
echo "ver 3.4.0-0"
php ojs-3.4.0-0/tools/upgrade.php upgrade

echo ""
echo "----> ver 3.4.0-1"
php ojs-3.4.0-1/tools/upgrade.php upgrade

echo ""
echo "----> ver 3.4.0-2"
php ojs-3.4.0-2/tools/upgrade.php upgrade

echo ""
echo "----> ver 3.4.0-3"
php ojs-3.4.0-3/tools/upgrade.php upgrade

echo ""
echo "----> ver 3.4.0-4"
php ojs-3.4.0-4/tools/upgrade.php upgrade

echo ""
echo "----> ver 3.4.0-5"
php ojs-3.4.0-5/tools/upgrade.php upgrade

echo ""
echo "----> ver 3.4.0-6"
php ojs-3.4.0-6/tools/upgrade.php upgrade

echo ""
echo "----> ver 3.4.0-7"
php ojs-3.4.0-7/tools/upgrade.php upgrade

echo ""
echo "----> ver 3.4.0-8"
php ojs-3.4.0-8/tools/upgrade.php upgrade

echo ""
echo "----> ver 3.4.0-9"
php ojs-3.4.0-9/tools/upgrade.php upgrade

echo ""
echo "= = = = = = = = = = = = = ="
echo "fin de las actualizaciones"
echo "= = = = = = = = = = = = = ="
echo ""
