# USER_DOC

## Overview

This project provides a complete WordPress infrastructure running inside Docker containers.

Available services:

* NGINX (HTTPS reverse proxy)
* WordPress with PHP-FPM
* MariaDB database

All services are orchestrated with Docker Compose.

---

## Starting the Project

To build and start all services:

```bash
make
```

or

```bash
make up
```

---

## Stopping the Project

To stop the services:

```bash
make down
```

To stop containers without removing them:

```bash
make stop
```

---

## Accessing the Website

Open the following URL in a browser:

```text
https://daafonso.42.fr
```

A security warning may appear because the project uses a self-signed TLS certificate.

Accept the warning and continue.

---

## Accessing the Administration Panel

Open:

```text
https://daafonso.42.fr/wp-admin
```

Login using the administrator credentials defined in `.env`.

Example:

```text
Username: allpower42
Password: ********
```

---

## Credentials

Credentials are stored in:

```text
srcs/.env
```

Examples:

```env
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser

WP_ADMIN_USER=allpower42
WP_ADMIN_PASSWORD=********
```

---

## Checking Services

Display running containers:

```bash
make ps
```

or

```bash
docker ps
```

Expected services:

* nginx
* wordpress
* mariadb

---

## Viewing Logs

Display all logs:

```bash
make logs
```

Display logs for a specific container:

```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```

---

## Verifying Website Availability

From the host:

```bash
curl -k https://daafonso.42.fr
```

The command should return the WordPress homepage HTML.
