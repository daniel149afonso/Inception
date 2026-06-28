# Build Adminer Image
# Download Debian Bullseye
FROM debian:bullseye

#install adminer on the image 
RUN apt-get update && \
    apt-get install -y adminer

COPY script.sh /script.sh

RUN chmod +x /script.sh

CMD ["/script.sh"]