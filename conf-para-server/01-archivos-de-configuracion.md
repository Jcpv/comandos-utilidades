
# Conf de httpd
sudo vim /etc/httpd/conf/httpd.conf 
sudo vim /etc/httpd/conf.d/ssl.conf (cd /etc/httpd/conf.d) 


# Otras configuraciones 
sudo vim /etc/mysql/my.cnf or /etc/my.cnf 
sudo vim /etc/hosts.allow 
sudo vim /etc/php.ini (buscar la ruta en el archivo index.php)
sudo vim /etc/sysconfig/iptables 
sudo vim /etc/ssh/sshd_config 
sudo vim /etc/httpd/conf.d/phpMyAdmin.conf 
sudo vi /etc/selinux/config 
sudo vi /etc/yum.conf (installonly_limit=2 solo para kernel)  

sudo nano /etc/apache2/apache2.conf



# Conf de Ubuntu
sudo nano /etc/apache2/sites-available/uifs-ssl.conf 
    <VirtualHost *:443> 
        ServerName uifs.cimsur.unam.mx 
        ServerAlias uifs.cimsur.unam.mx 

        DocumentRoot /var/www/html 

        SSLEngine on 
        SSLCertificateFile /home/tic/ssl/Wc_cimsur.unam.mx.cer  
        SSLCertificateChainFile /home/tic/ssl/UNAM_RSA_OV_SSL_CA.pem  
        SSLCertificateKeyFile /home/tic/ssl/cimsurdomain.key  
        SSLCACertificatefile /home/tic/ssl/UNAM_Root_R3_raiz.pem 

        <Directory /var/www/html> 
            Options Indexes FollowSymLinks 
            AllowOverride All 
            Require all granted 
        </Directory> 

        ErrorLog ${APACHE_LOG_DIR}/error.log 
        CustomLog ${APACHE_LOG_DIR}/access.log combined 
    </VirtualHost> 

## hacer esto para aplicar en UBUNTU
sudo a2enmod ssl
sudo a2ensite uifs-ssl.conf
sudo systemctl reload apache2



