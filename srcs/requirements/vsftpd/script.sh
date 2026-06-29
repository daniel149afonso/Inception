#!/bin/bash

set -e

if ! id "${FTP_USER}" >/dev/null 2>&1; then
    useradd -d /var/www/html -s /bin/bash "${FTP_USER}"
    echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd
fi

chown -R "${FTP_USER}:${FTP_USER}" /var/www/html

echo "Starting FTP server..."

mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd
chmod 555 /var/run/vsftpd/empty

exec vsftpd /etc/vsftpd/vsftpd.conf