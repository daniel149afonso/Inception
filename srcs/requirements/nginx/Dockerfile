# Build nginx Image
# Download Debian Bullseye
FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
    nginx \
    openssl

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=Inception/CN=daafonso.42.fr"

    # use the default.conf file
COPY default.conf /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]