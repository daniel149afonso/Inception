# Build FTP Image
# Download Debian Bullseye
FROM debian:bullseye

#install FTP on the image 
RUN apt-get update && \
    apt-get install -y redis-server

COPY script.sh /script.sh

RUN chmod +x /script.sh

CMD ["/script.sh"]