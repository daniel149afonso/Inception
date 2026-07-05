# *This project has been created as part of the 42 curriculum by daafonso.*

# Inception

## Description

Inception is a system administration and DevOps project from the 42 curriculum. The objective is to design and deploy a small infrastructure using Docker and Docker Compose.

The infrastructure is composed of several isolated services running in dedicated containers:

* NGINX configured with TLSv1.2/TLSv1.3
* WordPress with PHP-FPM
* MariaDB
* Docker volumes for persistent data
* A dedicated Docker network for inter-container communication

The project demonstrates containerization principles, service isolation, networking, persistent storage management, and secure communication through HTTPS.

---

## Project Architecture

```text
Internet
    |
    v
NGINX (TLS/HTTPS)
    |
    v
WordPress + PHP-FPM
    |
    v
MariaDB
```

### Services

#### NGINX

The NGINX container is the only entry point of the infrastructure. It listens on port 443 and handles HTTPS requests using a self-signed TLS certificate.

#### WordPress

The WordPress container contains:

* WordPress source files
* PHP-FPM
* WP-CLI

It communicates with MariaDB through the Docker network.

#### MariaDB

The MariaDB container stores the WordPress database and provides persistent data storage through a Docker volume.

---

## Project Structure

```text
.
├── Makefile
├── README.md
├── srcs
│   ├── docker-compose.yml
│   ├── .env
│   └── requirements
│       ├── mariadb
│       │   ├── Dockerfile
│       │   └── script.sh
│       ├── nginx
│       │   ├── Dockerfile
│       │   └── default.conf
│       └── wordpress
│           ├── Dockerfile
│           └── script.sh
└── secrets
```

---

## Instructions

### Prerequisites

* Linux environment (or WSL2)
* Docker
* Docker Compose

### Configure the domain

Add the following line to your hosts file:

```text
127.0.0.1 daafonso.42.fr
```

Linux:

```bash
sudo nano /etc/hosts
```

Windows:

```text
C:\Windows\System32\drivers\etc\hosts
```

### Build and start the project

```bash
make
```

or

```bash
make up
```

### Stop the project

```bash
make down
```

### Remove containers and volumes

```bash
make clean
```

### Complete cleanup

```bash
make fclean
```

---

## Access

Website:

```text
https://daafonso.42.fr
```

WordPress administration:

```text
https://daafonso.42.fr/wp-admin
```

---

## Persistent Storage

Two Docker volumes are used:

### WordPress Volume

Stores:

* WordPress source files
* Themes
* Plugins
* Uploads

### MariaDB Volume

Stores:

* Database files
* Tables
* User data

These volumes ensure data persistence even if containers are removed.

---

## Docker Concepts

### Virtual Machines vs Docker

#### Virtual Machines

A virtual machine emulates an entire operating system and requires a dedicated kernel.

Advantages:

* Strong isolation
* Multiple operating systems possible

Disadvantages:

* High resource consumption
* Slower startup

#### Docker

Docker uses containerization and shares the host kernel.

Advantages:

* Lightweight
* Fast startup
* Efficient resource usage

Disadvantages:

* Less isolation than a full VM

For this project, Docker provides a lightweight and reproducible environment.

---

### Secrets vs Environment Variables

#### Environment Variables

Environment variables are used to configure applications dynamically.

Advantages:

* Easy to use
* Required by the subject

Disadvantages:

* Visible from container configuration

#### Docker Secrets

Docker Secrets provide secure storage for sensitive data.

Advantages:

* Better security
* Not exposed as environment variables

Disadvantages:

* More complex setup

This project uses environment variables stored in a `.env` file, as required by the subject.

---

### Docker Network vs Host Network

#### Host Network

Containers share the host network stack directly.

Advantages:

* Simplicity

Disadvantages:

* Reduced isolation
* Forbidden by the subject

#### Docker Bridge Network

Containers communicate through an isolated virtual network.

Advantages:

* Isolation
* Service discovery by container name
* Better security

This project uses a dedicated Docker bridge network.

---

### Docker Volumes vs Bind Mounts

#### Bind Mounts

Direct mapping of host directories into containers.

Advantages:

* Easy file access

Disadvantages:

* Host-dependent
* Less portable

#### Docker Volumes

Managed directly by Docker.

Advantages:

* Better portability
* Easier backup and management

This project uses Docker named volumes for data persistence.

---

## Technical Choices

### Debian

All containers are built from Debian Bullseye.

Reasons:

* Stability
* Large package repository
* Compliance with project requirements

### PHP-FPM

NGINX cannot execute PHP code directly.

PHP-FPM handles PHP execution and communicates with NGINX through FastCGI.

### TLS

TLS encrypts communication between the client and the server.

The project uses a self-signed certificate generated during container initialization.

---

## AI Usage

Artificial intelligence tools were used as learning and troubleshooting assistants.

AI was used for:

* Understanding Docker concepts
* Debugging networking issues
* Diagnosing MariaDB connectivity problems
* Understanding NGINX and PHP-FPM interactions
* Reviewing project architecture

All implementation, configuration, testing, and validation were performed manually.

---

## Resources

### Docker

* https://docs.docker.com/
* https://docs.docker.com/compose/

### NGINX

* https://nginx.org/en/docs/

### MariaDB

* https://mariadb.org/documentation/

### WordPress

* https://wordpress.org/documentation/

### PHP-FPM

* https://www.php.net/manual/en/install.fpm.php

### OpenSSL

* https://www.openssl.org/docs/

### 42 Inception Subject

* Official project subject provided by 42 School.

# Bonus Features

The project includes the following bonus services running in dedicated Docker containers.

---

## Redis Cache

Redis is used as an in-memory object cache for WordPress in order to improve performance by reducing database queries.

### Architecture

```text
Client
   |
   v
NGINX
   |
   v
WordPress
   |
   +------------+
   |            |
   v            v
MariaDB      Redis
```

### Configuration

The Redis container runs a dedicated Redis server configured to listen on port **6379**.

The WordPress container includes:

* PHP Redis extension (`php-redis`)
* WP-CLI
* Redis Object Cache plugin

During initialization, the startup script:

* installs the Redis Object Cache plugin if necessary;
* activates the plugin;
* configures the Redis host and port;
* enables the Redis object cache.

The Redis service communicates with WordPress through the Docker bridge network.

### Verification

Redis can be verified with:

```bash
docker exec wordpress wp --path=/var/www/html redis status --allow-root
```

A successful configuration displays:

```text
Status: Connected
Client: PhpRedis
Redis Version: ...
```

---

## FTP Server (vsftpd)

A dedicated FTP server allows secure management of the WordPress files stored in the shared volume.

### Features

* Dedicated FTP user
* Anonymous access disabled
* Write permissions enabled
* Users restricted to their home directory (`chroot`)
* Passive mode enabled

### Shared Volume

The FTP container shares the same WordPress volume:

```text
WordPress
      |
      |
wordpress_data
      |
      |
   vsftpd
```

Any file uploaded through FTP is immediately available to WordPress.

### Ports

* FTP control connection: **21**
* Passive mode: **30000-30010**

---

## Adminer

Adminer provides a lightweight web interface for MariaDB administration.

It allows:

* browsing databases;
* executing SQL queries;
* managing tables;
* inspecting WordPress data.

### Access

```text
http://localhost:8080
```

Connection parameters:

* System: MariaDB
* Server: `mariadb`
* Username: value of `MYSQL_USER`
* Password: value of `MYSQL_PASSWORD`
* Database: value of `MYSQL_DATABASE`

---

## Static Website

A second NGINX container serves a completely static website written in HTML, CSS and JavaScript.

Unlike WordPress, this website:

* does not use PHP;
* does not require a database;
* serves static files only.

### Access

```text
http://localhost:8081
```

This demonstrates the deployment of multiple independent web services within the same Docker infrastructure.

---

## Trivy Security Scanner

Trivy is used as a security analysis tool for Docker images.

It scans installed packages and compares their versions against a vulnerability database (CVE - Common Vulnerabilities and Exposures).

Typical vulnerabilities detected include:

* Critical
* High
* Medium
* Low

### Why Trivy?

Adding Trivy introduces a security layer into the infrastructure by allowing vulnerability assessment before deployment.

### Example

Scan an image:

```bash
docker exec trivy trivy image srcs-wordpress
```

Only display critical and high vulnerabilities:

```bash
docker exec trivy trivy image srcs-wordpress --severity HIGH,CRITICAL
```

Trivy analyzes packages installed inside the image (such as OpenSSL, zlib, util-linux, PHP packages, etc.) and reports known vulnerabilities using the official CVE database.

---

# Final Infrastructure

```text
                         Internet
                             |
                             v
                    NGINX (HTTPS / TLS)
                             |
                             v
                    WordPress + PHP-FPM
                       |            |
                       |            |
                       v            v
                   MariaDB       Redis
                       ^
                       |
                 Adminer (Web UI)

WordPress Volume
      |
      +----------------------+
      |                      |
      v                      v
  WordPress               vsftpd

Static Website
      |
      v
 Static NGINX

Security

Trivy
   |
   v
Docker Images
```

## Bonus Summary

| Service        | Purpose                                 |
| -------------- | --------------------------------------- |
| Redis          | WordPress object cache                  |
| vsftpd         | FTP access to WordPress files           |
| Adminer        | MariaDB web administration              |
| Static Website | Independent HTML/CSS/JavaScript website |
| Trivy          | Docker image vulnerability scanner      |
