#!/bin/bash

set -e

# check if the ftp user doesnt exist, add the user and define the password
if ! id "${FTP_USER}" >/dev/null 2>&1; then
    useradd -d /var/www/html -s /bin/bash "${FTP_USER}"
    echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd
fi

# the ftp user owns all the files
chown -R "${FTP_USER}:${FTP_USER}" /var/www/html

echo "Starting FTP server..."

mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd
chmod 555 /var/run/vsftpd/empty

exec vsftpd /etc/vsftpd/vsftpd.conf