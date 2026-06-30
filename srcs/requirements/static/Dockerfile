# Build static site Image
# Download Debian Bullseye
FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

COPY site /var/www/html

COPY script.sh /script.sh

RUN chmod +x /script.sh

EXPOSE 80

CMD ["/script.sh"]