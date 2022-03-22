#!/bin/bash

#instala dependencias

sudo apt update
sudo apt install -y apache2 \
                    ghostscript \
                    libapache2-mod-php \
                    mysql-server \
                    php \
                    php-bcmath \
                    php-curl \
                    php-imagick \
                    php-intl \
                    php-json \
                    php-mbstring \
                    php-mysql \
                    php-xml \
                    php-zip


#Instala Wordpress

sudo mkdir -p /srv/www
sudo chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www

#Configura Wordpress

cd /etc/apache2/sites-available/
touch wordpress.conf

echo '<VirtualHost *:80>' >> wordpress.conf
echo '    DocumentRoot /srv/www/wordpress' >> wordpress.conf
echo '    <Directory /srv/www/wordpress>' >> wordpress.conf
echo '        Options FollowSymLinks' >> wordpress.conf
echo '        AllowOverride Limit Options FileInfo' >> wordpress.conf
echo '        DirectoryIndex index.php' >> wordpress.conf
echo '        Require all granted' >> wordpress.conf
echo '    </Directory>' >> wordpress.conf
echo '    <Directory /srv/www/wordpress/wp-content>' >> wordpress.conf
echo '        Options FollowSymLinks' >> wordpress.conf
echo '        Require all granted' >> wordpress.conf
echo '    </Directory>' >> wordpress.conf
echo '</VirtualHost>' >> wordpress.conf

#Habilitando Site
sudo a2ensite wordpress

#para ativar a reescrita
sudo a2enmod rewrite

#para desativar o site padrão
sudo a2dissite 000-default



