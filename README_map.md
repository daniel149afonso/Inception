# Build mariadb image (need to specify the path to Dockerfile)
docker compose up --build -d

# Create and start the container
docker compose up -d (start all container wordpress, nginx too. -d -> for detached mode make you free)

# enter in the container
docker exec -it mariadb bash

# know mariadb version
which mariadbd

# change the user permissions
chown mysql:mysql /run/mysqld

# start Mariadb, crate socket, start server, open the port
mariadb 

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