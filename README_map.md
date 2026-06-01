# Create mariadb image
docker build -t mariadb-test

# lauch the container
docker run -it --rm mariadb-test bash

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