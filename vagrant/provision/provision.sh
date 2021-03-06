#!/usr/bin/env bash


echo "=================================================="
echo "Aloha! Now we will try to Install Ubuntu 16.04 LTS"
echo "with Nginx, PHP-FPM, MariaDB (MySQL)"
echo "and others dependencies needed for Magento2"
echo "Good luck :P"
echo "=================================================="
echo ""
echo ""
echo "=================================================="
echo "RUN UPDATE"
echo "=================================================="
add-apt-repository ppa:ondrej/php
apt-get -y update


echo ""
echo ""
echo "=================================================="
echo "SET LOCALES"
echo "=================================================="
locale-gen ru_RU.UTF-8


echo ""
echo ""
echo "=================================================="
echo "INSTALL NGINX"
echo "=================================================="
apt-get -y install nginx
service nginx start

echo "set up nginx server"
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
cp /vagrant/provision/nginx/nginx.conf /etc/nginx/nginx.conf
cp /vagrant/provision/nginx/magento.conf /etc/nginx/sites-available/magento.conf
cp /vagrant/provision/nginx/magento-nginx.conf.sample /etc/nginx/magento-nginx.conf.sample

ln -s /etc/nginx/sites-available/magento.conf /etc/nginx/sites-enabled/magento.conf

rm -rf /etc/nginx/sites-enabled/default

echo ""
echo ""
echo "=================================================="
echo "INSTALL PHP-FPM"
echo "=================================================="
apt-get -y install php7.2-fpm php7.2-curl php7.2-cli php7.2-mysql php7.2-gd php7.2-xsl php7.2-json php7.2-intl php-pear php7.2-dev php7.2-common php7.2-mbstring php7.2-zip php7.2-soap libcurl3 curl php7.2-bcmath



echo ""
echo ""
echo "=================================================="
echo "INSTALL MariaDB"
echo "=================================================="
apt-get install mariadb-server mariadb-client -y


echo "=================================================="
echo "INSTALL COMPOSER"
echo "=================================================="
cd /home/ubuntu/
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer


echo ""
echo ""
echo "=================================================="
echo "RELOAD SOFT"
echo "=================================================="
systemctl restart {nginx,php7.2-fpm}


echo ""
echo ""
echo "=================================================="
echo "CLEANING..."
echo "=================================================="
apt-get -y autoremove
apt-get -y autoclean

echo ""
echo ""
echo "=================================================="
echo "UPDATE PROFILE"
echo "=================================================="
echo "export PATH=$PATH:/var/www/magento2/bin" >> /home/ubuntu/.bash_profile
usermod -a -G www-data ubuntu

echo "=================================================="
echo "============= INSTALLATION COMPLETE =============="
echo "=================================================="
