## Servicios a iniciar  

systemctl enable iptables 
systemctl start iptables 
sudo systemctl restart php-fpm httpd iptables mariadb 
sudo firewall-cmd --reload 

