# Build Wordpress Image
# Download Debian Bullseye
FROM debian:bullseye

# install redis extension to use redis
RUN apt-get update && \
    apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php-redis \ 
    wget \
    tar \
    mariadb-client && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

RUN mkdir -p /var/www/html && \
    wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /tmp && \
    cp -r /tmp/wordpress/* /var/www/html/

RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' \
    /etc/php/7.4/fpm/pool.d/www.conf

COPY script.sh /script.sh

RUN chmod +x /script.sh

CMD ["/script.sh"]