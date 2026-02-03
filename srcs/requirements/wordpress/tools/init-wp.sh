#!/bin/sh
set -e
cd /var/www/html

mkdir -p /run/php

# Check if WordPress is already installed
if [ ! -f wp-config.php ]; then

    # 1. WP-CLI Download and Installation
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar

    # Wait for a few seconds
    sleep 10

    # 2. WordPress Core Download
    ./wp-cli.phar core download --allow-root

    echo "Debug: DB Password is: $(cat /run/secrets/wp_db_password)"
    # 3. wp-config.php Creation
    ./wp-cli.phar config create \
     --dbname=${WORDPRESS_DB_NAME} \
     --dbuser=${WORDPRESS_DB_USER} \
     --dbpass=$(cat /run/secrets/wp_db_password) \
     --dbhost=${WORDPRESS_DB_HOST} \
     --allow-root

    # 4. Database Installation
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