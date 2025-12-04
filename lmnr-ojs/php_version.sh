#!/bin/bash
set -e

echo "=== Selecciona la versión de PHP para CLI ==="
# Mostrar el menú de alternativas
sudo update-alternatives --config php

read -p "==> Ingresa NUEVAMENTE el número de selección: " SELECCION

# Aplicar selección
sudo update-alternatives --set php $(update-alternatives --list php | sed -n "${SELECCION}p")

echo "Versión de PHP CLI seleccionada:"
php -v

echo " - - - - - - - - - - - - - - - - - - - - - -"
echo " === CAMBIANDO VERSION DE PHP EN APACHE === "
echo "- - - - - - - - - - - - - - - - - - - - - "
read -p "Ingresa la versión de PHP para Apache (ej: 7.4, 8.0, 8.1, 8.4): " PHPVER


sudo a2dismod php7.4 php8.0 php8.1 php8.4 2>/dev/null || true
sudo a2enmod php$PHPVER
#sudo a2enmod php8.1 || true

echo "=== Reiniciando APACHE  ==="

sudo systemctl restart apache2