# Build FTP Image
# Download Debian Bullseye
FROM debian:bullseye

#install FTP on the image 
RUN apt-get update && \
    apt-get install -y vsftpd && \
    rm -rf /var/lib/apt/lists/*

COPY script.sh /script.sh

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN chmod +x /script.sh

CMD ["/script.sh"]