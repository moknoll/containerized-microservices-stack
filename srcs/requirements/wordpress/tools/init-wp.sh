#!/bin/sh
set -e
cd /var/www/html

mkdir -p /run/php

# Check if WordPress is already installed
if [ ! -f wp-cli.phar ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
fi

# 2. WordPress Core Download (only if missing)
# Prevents "Error: WordPress files seem to already exist"
if [ ! -f index.php ]; then
    ./wp-cli.phar core download --allow-root
fi

# 3. Configuration & Installation (only if config missing)
if [ ! -f wp-config.php ]; then

    # Create config
    ./wp-cli.phar config create \
     --dbname=${WORDPRESS_DB_NAME} \
     --dbuser=${WORDPRESS_DB_USER} \
     --dbpass=$(cat /run/secrets/wp_db_password) \
     --dbhost=${WORDPRESS_DB_HOST} \
     --allow-root

    # Database Installation
    ./wp-cli.phar core install \
     --url="mknoll.42.fr" \
     --title="Inception" \
     --admin_user=${WP_ADMIN_USER} \
     --admin_password=$(cat /run/secrets/wp_admin_password) \
     --admin_email=${WP_ADMIN_EMAIL} \
     --allow-root
fi 

# Start PHP-FPM in foreground
exec php-fpm7.4 -F