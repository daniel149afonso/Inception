# Build Mariadb Image
# Download Debian Bullseye
FROM debian:bullseye

#install mariadb on the image 
RUN apt-get update && \
    apt-get install -y mariadb-server

COPY script.sh /script.sh

RUN chmod +x /script.sh

CMD ["/script.sh"]