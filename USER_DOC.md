# USER_DOC

## Overview

This project provides a complete WordPress infrastructure running inside Docker containers.

Available services:

* NGINX (HTTPS reverse proxy)
* WordPress with PHP-FPM
* MariaDB
* Redis cache
* Adminer
* FTP server (vsftpd)
* Static website
* Trivy security scanner

All services are orchestrated using Docker Compose.

---

# Starting the Project

Build and start all services:

```bash
make
```

or

```bash
make up
```

---

# Stopping the Project

Stop and remove containers:

```bash
make down
```

Stop containers without removing them:

```bash
make stop
```

---

# Cleaning the Project

Remove containers and volumes:

```bash
make clean
```

Complete rebuild:

```bash
make re
```

---

# Accessing the Services

## WordPress

Website:

```text
https://daafonso.42.fr
```

Because a self-signed TLS certificate is used, your browser may display a security warning.

Accept the warning to continue.

---

## WordPress Administration

```text
https://daafonso.42.fr/wp-admin
```

Login using the administrator credentials stored in:

```text
srcs/.env
```

Example:

```text
Username: admin
Password: ********
```

---

## Adminer

Adminer provides a graphical interface for MariaDB.

Open:

```text
http://localhost:8080
```

Connection parameters:

* System: MariaDB
* Server: mariadb
* Username: MYSQL_USER
* Password: MYSQL_PASSWORD
* Database: MYSQL_DATABASE

---

## Static Website

The project also includes a simple static website.

Open:

```text
http://localhost:8081
```

---

## FTP Server

The FTP server provides access to the WordPress files stored in the shared Docker volume.

Connection parameters:

```text
Host: localhost
Port: 21
Username: FTP_USER
Password: FTP_PASSWORD
```

The credentials are defined in:

```text
srcs/.env
```

---

# Configuration

All project configuration values are stored in:

```text
srcs/.env
```

Example:

```env
DOMAIN_NAME=daafonso.42.fr

MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=********

WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=********

FTP_USER=ftpuser
FTP_PASSWORD=********
```

---

# Service Status

Display all running services:

```bash
make ps
```

or

```bash
docker compose ps
```

Expected services:

* nginx
* wordpress
* mariadb
* redis
* adminer
* vsftpd
* static
* trivy

---

# Viewing Logs

Display logs for every service:

```bash
make logs
```

Display logs for a single container:

```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
docker logs redis
docker logs adminer
docker logs vsftpd
docker logs static
docker logs trivy
```

---

# Verifying the Website

From the host:

```bash
curl -k https://daafonso.42.fr
```

The command should return the HTML of the WordPress homepage.

---

# Verifying Redis

Redis should be connected to WordPress.

Check its status:

```bash
docker exec wordpress \
wp --path=/var/www/html redis status --allow-root
```

Expected output:

```text
Status: Connected
```

---

# Verifying FTP

Using an FTP client, connect to:

```text
Host: localhost
Port: 21
```

You should be able to browse and modify the WordPress files.

---

# Verifying Trivy

Check the installed version:

```bash
docker exec trivy trivy --version
```

Example:

```text
Version: 0.xx.x
```

Scan a Docker image:

```bash
docker exec trivy \
trivy image srcs-wordpress
```

Display only High and Critical vulnerabilities:

```bash
docker exec trivy \
trivy image srcs-wordpress \
--severity HIGH,CRITICAL
```

---

# Troubleshooting

## Website unavailable

Verify that all containers are running:

```bash
docker compose ps
```

---

## HTTPS certificate warning

The project uses a self-signed TLS certificate.

This warning is expected.

Accept the certificate to access the website.

---

## Cannot connect to FTP

Verify that the FTP container is running:

```bash
docker logs vsftpd
```

---

## Redis not connected

Check:

```bash
docker exec wordpress \
wp --path=/var/www/html redis status --allow-root
```

The status should be:

```text
Status: Connected
```

---

## Adminer unavailable

Verify:

```text
http://localhost:8080
```

and check the container logs:

```bash
docker logs adminer
```
