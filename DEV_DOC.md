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
        ├── mariadb
        ├── nginx
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

WP_ADMIN_USER=allpower42
WP_ADMIN_PASSWORD=********
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

Each image is built from its own Dockerfile.

---

## Useful Commands

### Show running containers

```bash
make ps
```

### Follow logs

```bash
make logs
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

Database files are stored in:

```text
/home/daniel/data/mariadb
```

Mounted in the container as:

```text
/var/lib/mysql
```

---

### WordPress

Website files are stored in:

```text
/home/daniel/data/wordpress
```

Mounted in the containers as:

```text
/var/www/html
```

---

## Docker Volumes

List volumes:

```bash
docker volume ls
```

Inspect a volume:

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

Inspect project network:

```bash
docker network inspect srcs_inception
```

Containers communicate using service names:

```text
wordpress -> mariadb
nginx -> wordpress
```

---

## Troubleshooting

### WordPress cannot connect to MariaDB

Check:

```bash
docker logs mariadb
docker logs wordpress
```

Verify database connectivity:

```bash
docker exec wordpress mysqladmin ping -hmariadb
```

---

### NGINX returns 502 Bad Gateway

Verify PHP-FPM:

```bash
docker logs wordpress
```

Verify FastCGI connectivity:

```bash
docker exec nginx nc -zv wordpress 9000
```

---

### Verify TLS

```bash
openssl s_client -connect localhost:443 -tls1_2
```

```bash
openssl s_client \
    -connect daafonso.42.fr:443 \
    -servername daafonso.42.fr
```
Expected:

```text
Protocol : TLSv1.2
```
