# Build Wordpress Image
# Download Debian Bullseye
FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    wget

COPY script.sh /script.sh

RUN chmod +x /script.sh

CMD ["/script.sh"]