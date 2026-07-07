#!/bin/bash

set -e

mkdir -p /run/php

echo "Waiting for MariaDB..."

# Attente DB (root = fiable)
until mysqladmin ping -hmariadb -uroot -p"${MYSQL_ROOT_PASSWORD}" --silent; do
    sleep 2
done

echo "MariaDB is ready"

# download wordpress in the volumes
if [ ! -f /var/www/html/wp-load.php ]; then
    wp core download --path=/var/www/html --allow-root
fi

# Config WordPress (idempotent)
if [ ! -f /var/www/html/wp-config.php ]; then
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

    sed -i "s/database_name_here/${MYSQL_DATABASE}/" /var/www/html/wp-config.php
    sed -i "s/username_here/${MYSQL_USER}/" /var/www/html/wp-config.php
    sed -i "s/password_here/${MYSQL_PASSWORD}/" /var/www/html/wp-config.php
    sed -i "s/localhost/mariadb/" /var/www/html/wp-config.php
fi

cd /var/www/html

# Installation WordPress sécurisée
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."

    wp core install \
        --url="https://daafonso.42.fr" \
        --title="Inception" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root

    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role=author \
        --allow-root
fi

# redis plugin installation
# check if the plugin is installed
echo "Configuring Redis..."

if ! wp plugin is-installed redis-cache --allow-root; then
    wp plugin install redis-cache --allow-root
fi
# check if the plugin is activated
if ! wp plugin is-active redis-cache --allow-root; then
    wp plugin activate redis-cache --allow-root
fi

if ! wp config has WP_REDIS_HOST --allow-root; then
    wp config set WP_REDIS_HOST redis --allow-root
fi

if ! wp config has WP_REDIS_PORT --allow-root; then
    wp config set WP_REDIS_PORT 6379 --raw --allow-root
fi

if [ ! -f /var/www/html/wp-content/object-cache.php ]; then
    wp redis enable --allow-root
fi

echo "Starting PHP-FPM..."

exec php-fpm7.4 -F