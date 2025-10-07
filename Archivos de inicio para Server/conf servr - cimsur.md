

# Archivo Conf de apache
sudo nano /etc/apache2/apache2.conf
sudo a2enmod headers


/etc/php/8.1/apache2/php.ini 


# Cambiar versión de PHP
sudo update-alternatives --config php
sudo a2dismod php8.0
sudo a2enmod php8.1
 sudo systemctl reload apache2
