sudo apt update && sudo apt upgrade -y
sudo apt install net-tools
sudo apt install apache2 mysql-server libapache2-mod-php php php-gd php-mysql php-curl php-mbstring php-intl php-gmp php-bcmath php-xml php-imagick php-zip unzip wget curl -y
sudo mysql_secure_installation
    Set root password (choose something strong)
    Remove anonymous users: Y
    Disallow root login remotely: Y
    Remove test database: Y
    Reload privilege tables: Y
sudo mysql -u root -p
    CREATE DATABASE nextcloud;
    CREATE USER 'nextclouduser'@'localhost' IDENTIFIED BY 'your_strong_password';
    GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextclouduser'@'localhost';
    FLUSH PRIVILEGES;
    EXIT;

cd /tmp
wget https://download.nextcloud.com/server/releases/latest.zip
unzip latest.zip
sudo cp -r nextcloud /var/www/html/
sudo chown -R www-data:www-data /var/www/html/nextcloud
sudo chmod -R 755 /var/www/html/nextcloud

sudo nano /etc/apache2/sites-available/nextcloud.conf
    <VirtualHost *:80>
        ServerName your-domain.com
        DocumentRoot /var/www/html/nextcloud

        <Directory /var/www/html/nextcloud>
            Options +FollowSymlinks
            AllowOverride All
            Require all granted
            <IfModule mod_dav.c>
                Dav off
            </IfModule>
            SetEnv HOME /var/www/html/nextcloud
            SetEnv HTTP_HOME /var/www/html/nextcloud
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/nextcloud_error.log
        CustomLog ${APACHE_LOG_DIR}/nextcloud_access.log combined
    </VirtualHost>

sudo a2enmod rewrite headers env dir mime setenvif ssl
sudo a2ensite nextcloud.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2

sudo nano /etc/php/8.1/apache2/php.ini

    memory_limit = 512M
    upload_max_filesize = 500M
    post_max_size = 500M
    max_execution_time = 300
    max_input_time = 300

sudo systemctl restart apache2

Open your browser and go to http://your-server-ip/nextcloud

sudo apt install snapd
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --apache -d your-domain.com

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nextcloud.key -out /etc/ssl/certs/nextcloud.crt

sudo crontab -u www-data -e
    */5 * * * * php /var/www/html/nextcloud/cron.php

sudo apt install redis-server php-redis
sudo systemctl enable redis-server

sudo nano /var/www/html/nextcloud/config/config.php
    'memcache.local' => '\OC\Memcache\Redis',
    'redis' => array(
        'host' => 'localhost',
        'port' => 6379,
    ),


