# Build Wordpress Image
# Download Debian Bullseye
FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    wget \
    tar

RUN mkdir -p /var/www/html && \
    wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /tmp && \
    cp -r /tmp/wordpress/* /var/www/html/

COPY script.sh /script.sh

RUN chmod +x /script.sh

CMD ["/script.sh"]