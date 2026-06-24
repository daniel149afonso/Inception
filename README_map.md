à check redirige vers login.intra

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

# start Mariadb, crate socket, start server, open the port
mariadb 

# show the host and his ip address
getent hosts mariadb

# show the TCP listening ports of the container (0.0.0.0 means all  network interfaces)
docker exec mariadb ss -ltnp

# connect to mariadb (to use in the wordpress container)
php -r '$c = new mysqli("mariadb", "wpuser", "TON_MOT_DE_PASSE", "wordpress"); if ($c->connect_error) { echo "ERREUR: ".$c->connect_error.PHP_EOL; exit(1); } echo "OK connexion MariaDB".PHP_EOL;'

# connect to the server
curl -k https://localhost

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

# à faire
sur les machines de l'école modifier daniel par daafonso pour les volumes docker