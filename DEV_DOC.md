# DEV_DOC

## Development Environment

### Requirements

* Docker
* Docker Compose
* GNU Make
* Linux or WSL2

---

## Project Structure

```text
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
└── srcs
    ├── docker-compose.yml
    ├── .env
    └── requirements
        ├── adminer
        ├── mariadb
        ├── nginx
        ├── redis
        ├── static
        ├── trivy
        ├── vsftpd
        └── wordpress
```

---

## Configuration

All configuration values are stored in:

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
WP_ADMIN_EMAIL=admin@example.com

WP_USER=user
WP_USER_PASSWORD=********
WP_USER_EMAIL=user@example.com

FTP_USER=ftpuser
FTP_PASSWORD=********
```

---

## Building the Project

Build and start the infrastructure:

```bash
make
```

or

```bash
make up
```

Docker Compose builds the following images:

* nginx
* wordpress
* mariadb
* redis
* adminer
* vsftpd
* static
* trivy

Each service is built from its own Dockerfile.

---

## Useful Commands

### Show running containers

```bash
make ps
```

or

```bash
docker compose ps
```

### Follow logs

```bash
make logs
```

or

```bash
docker compose logs -f
```

### Restart a single service

```bash
docker compose restart <service>
```

Example:

```bash
docker compose restart wordpress
```

### Open a shell inside a container

```bash
docker exec -it <container> bash
```

Example:

```bash
docker exec -it wordpress bash
```

### Stop services

```bash
make stop
```

### Remove containers

```bash
make down
```

### Remove containers and volumes

```bash
make clean
```

### Full rebuild

```bash
make re
```

---

## Persistent Data

### MariaDB

Host:

```text
/home/daniel/data/mariadb
```

Container:

```text
/var/lib/mysql
```

---

### WordPress

Host:

```text
/home/daniel/data/wordpress
```

Container:

```text
/var/www/html
```

This volume is shared by:

* WordPress
* NGINX
* vsftpd

---

## Docker Volumes

List volumes:

```bash
docker volume ls
```

Inspect:

```bash
docker volume inspect srcs_mariadb_data
docker volume inspect srcs_wordpress_data
```

---

## Docker Network

List networks:

```bash
docker network ls
```

Inspect:

```bash
docker network inspect srcs_inception
```

Services communicate using their Compose service names:

```text
nginx ------> wordpress
wordpress --> mariadb
wordpress --> redis
adminer ----> mariadb
```

---

# Service Verification

## NGINX

```bash
docker logs nginx
```

Check HTTPS:

```bash
curl -k https://daafonso.42.fr
```

---

## WordPress

Verify installation:

```bash
docker exec wordpress \
wp --path=/var/www/html core is-installed --allow-root
```

List plugins:

```bash
docker exec wordpress \
wp --path=/var/www/html plugin list --allow-root
```

---

## MariaDB

Check connectivity:

```bash
docker exec wordpress \
mysqladmin ping -hmariadb
```

---

## Redis

Verify Redis server:

```bash
docker exec redis redis-cli ping
```

Expected:

```text
PONG
```

Verify WordPress cache:

```bash
docker exec wordpress \
wp --path=/var/www/html redis status --allow-root
```

Expected:

```text
Status: Connected
```

---

## Adminer

Open:

```text
http://localhost:8080
```

Connect using:

* Server: mariadb
* Username: MYSQL_USER
* Password: MYSQL_PASSWORD

---

## FTP (vsftpd)

Verify server:

```bash
docker logs vsftpd
```

Example connection from host:

```bash
lftp -u FTP_USER,FTP_PASSWORD ftp://127.0.0.1
```

List files:

```bash
ls
```

---

## Static Website

Open:

```text
http://localhost:8081
```

Verify NGINX:

```bash
docker logs static
```

---

## Trivy

Verify installation:

```bash
docker exec trivy trivy --version
```

Scan an image:

```bash
docker exec trivy \
trivy image srcs-wordpress
```

Only High and Critical vulnerabilities:

```bash
docker exec trivy \
trivy image srcs-wordpress \
--severity HIGH,CRITICAL
```

---

# Troubleshooting

## WordPress cannot connect to MariaDB

Check logs:

```bash
docker logs mariadb
docker logs wordpress
```

Check connectivity:

```bash
docker exec wordpress \
mysqladmin ping -hmariadb
```

---

## Redis not connected

Check Redis:

```bash
docker exec redis redis-cli ping
```

Check WordPress:

```bash
docker exec wordpress \
wp --path=/var/www/html redis status --allow-root
```

---

## FTP connection refused

Verify container:

```bash
docker logs vsftpd
```

Verify ports:

```bash
docker compose ps
```

---

## Adminer unavailable

Check:

```bash
docker logs adminer
```

Verify:

```text
http://localhost:8080
```

---

## NGINX returns 502 Bad Gateway

Verify PHP-FPM:

```bash
docker logs wordpress
```

Check FastCGI:

```bash
docker exec nginx \
nc -zv wordpress 9000
```

---

## Verify TLS

```bash
openssl s_client \
-connect localhost:443 \
-tls1_2
```

or

```bash
openssl s_client \
-connect daafonso.42.fr:443 \
-servername daafonso.42.fr
```

Expected:

```text
Protocol : TLSv1.2
```

---

## Verify Infrastructure

```bash
docker compose ps
```

All services should be in the **Up** state before testing.
