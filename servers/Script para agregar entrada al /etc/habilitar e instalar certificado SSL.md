Paso 1: Crea o edita el VirtualHost en *:443

 sudo nano /etc/apache2/sites-enabled/cimsur-ssl.conf
 sudo nano /etc/apache2/sites-available/cimsur-ssl.conf   


<VirtualHost *:443>
    ServerName cimsur.unam.mx

    DocumentRoot /var/www/html

    SSLEngine on
    
        SSLCertificateFile /home/cimsur/ssl/Wc_cimsur.unam.mx.cer 
        SSLCertificateChainFile /home/cimsur/ssl/UNAM_RSA_OV_SSL_CA.pem 
        SSLCertificateKeyFile /home/cimsur/ssl/cimsurdomain.key 
        SSLCACertificatefile /home/cimsur/ssl/UNAM_Root_R3_raiz.pem


    #SSLCertificateFile      /etc/apache2/ssl/certificado.crt
    #SSLCertificateKeyFile   /etc/apache2/ssl/llave.key
    #SSLCertificateChainFile /etc/apache2/ssl/ca_bundle.crt

    <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

Paso 2: Habilita el módulo SSL y el nuevo sitio

sudo a2enmod ssl
sudo a2ensite cimsur-ssl.conf

# CREARA OTRO SIMILIAR DENTRO DE LA CARPETA sites-available











sudo nano /etc/apache2/sites-available/cimsur.unam.mx.conf
 <VirtualHost *:80>
    ServerName cimsur.unam.mx
    DocumentRoot /var/www/html

    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/cimsur_error.log
    CustomLog ${APACHE_LOG_DIR}/cimsur_access.log combined
</VirtualHost>