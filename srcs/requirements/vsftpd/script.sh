#!/bin/bash

useradd ...
echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd

exec vsftpd-server /etc/vsftpd/vsftpd.conf