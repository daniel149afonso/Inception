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

