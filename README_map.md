- NGINX : reçoit les requêtes HTTPS et les transmet à WordPress.
- WordPress : génère les pages dynamiques du site.
- PHP-FPM : exécute le code PHP de WordPress.
- MariaDB : stocke toutes les données du site.
- Redis : met en cache les données pour accélérer WordPress.
- Adminer : permet d'administrer MariaDB via une interface Web.
- vsftpd : permet de modifier les fichiers WordPress via FTP.
- Trivy : analyse les images Docker pour détecter des vulnérabilités connues.
- Static : héberge un site web statique indépendant.

# redis
Redis sert de cache pour WordPress : au lieu que WordPress redemande toujours certaines informations à MariaDB, il peut stocker temporairement des résultats dans Redis. Il sert à éviter de refaire certaines requêtes SQL.

# Create the container and use the existant image (if you didn't change the Dockerfile)
docker compose up -d (start all container wordpress, nginx too. -d -> for detached mode make you free)

# Create the container and rebuild the image based on the Dockerfile (if you changed the Dockerfile)
docker compose up --build -d

# enter in the container
docker exec -it mariadb bash

# know mariadb version
which mariadbd

# change the user permissions
chown mysql:mysql /run/mysqld

# start Mariadb, create socket, start server, open the port
mariadb -u root -p"$MYSQL_ROOT_PASSWORD"

# Sql commands to test
USE db_name, SELECT DATABASE(), SHOW TABLES

# show the host and his ip address
getent hosts mariadb

# show the TCP listening ports of the container (0.0.0.0 means all  network interfaces)
docker exec mariadb ss -ltnp

# connect to mariadb (to use in the wordpress container)
php -r '$c = new mysqli("mariadb", "wpuser", "TON_MOT_DE_PASSE", "wordpress"); if ($c->connect_error) { echo "ERREUR: ".$c->connect_error.PHP_EOL; exit(1); } echo "OK connexion MariaDB".PHP_EOL;'

# login page
https://daafonso.42.fr/wp-login.php

# connect to the nginx server
curl -k -I https://daafonso.42.fr

# check if WP-CLI exist in wordpress container
docker exec wordpress wp --info --allow-root

# list all registered wordpress users
docker exec wordpress bash -c 'cd /var/www/html && wp user list --allow-root'

#
docker inspect wordpress --format '{{ range .Mounts }}{{ .Name }} -> {{ .Destination }}{{ println }}{{ end }}'

# check the env variables
docker exec mariadb env | grep MYSQL

# show status of container
docker ps

# connect to the container
docker exec -it <container_id> bash

# stop the containers
docker compose stop

# delete the containers
docker compose down

# show the logs
docker logs mariadb

# show all saved docker images
docker images

# show all docker volumes
docker volume ls

# show all docker networks
docker network ls

# show restart policy
docker inspect wordpress --format '{{ .HostConfig.RestartPolicy.Name }}'

Conteneur MariaDB
│
├── /run/mysqld        -> temporaire (socket, temporary files, recreate at each restart)
└── /var/lib/mysql     -> IMPORTANT (db, tables, users, passwords)

/home/<login>/data/mariadb (host folder)

/home/<login>/data/wordpress

/home/<login>/data/mariadb
        ↓
volume Docker
        ↓
/var/lib/mysql

# Bonus:

# list all wordpress plugin
wp plugin list --path=/var/www/html --allow-
root

# redis status (in wordpress container)
wp --path=/var/www/html redis status --allow-root

# enter in redis client container
docker exec -it redis redis-cli

# PING redis (in redis container bash)
redis-cli PING

# list all db caches(db number, keys, 11 keys have an expiration, ttl in ms)
INFO keyspace 
> db0:keys=84,expires=11,avg_ttl=119347203

# count the number of keys
DBSIZE

# delete all caches
FLUSHDB

# show exposed ftp port
docker port vsftpd

# show ftp user
id $FTP_USER

# connect to the ftp server and list the files of the wordpress volume
lftp -u 'FTP_USER','FTP_PASSWORD' ftp://127.0.0.1 && ls

# show ftp share the same volume (in wordpress container)
ls -la /var/www/html

# show the current path && change directory of the local machine
lpwd, lcd

# upload the image to the wordpress volume
put image.png

# web broswer adminer
http://localhost:8080

server: mariadb
user: MYSQL_USER
password: MYSQL_PASSWORD

# check trivy version
docker exec -it trivy trivy --version

# scan trivy
docker exec trivy trivy image srcs-nginx

# scan trivy only HIGH, CRITICAL
docker exec trivy trivy image srcs-nginx --severity HIGH,CRITICAL

# à faire
sur les machines de l'école modifier daniel par daafonso pour les volumes docker
Modifier dans le makefile le chemin vers les volumes
