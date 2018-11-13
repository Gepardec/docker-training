# tag::build[]
# Build the Docker Image
docker image build -t todo-app:latest .
# end::build[]

# tag::volume[]
# Create the Docker Volume
docker volume create todo-db-vol
# end::volume[]

# tag::network[]
# Create the Docker Network
docker network create todo-net
# end::network[]

# tag::provision[]
# 1. Create the Docker Containers 
# 1.1 For todo-app 
docker container create \
    --name todo-app \
    --env "DB_URL=jdbc:mysql://todo-db:3306/todo" \
    --env "DB_USER=todo" \
    --env "DB_PASSWORD=todo" \
    --publish 8080:8080 \
    --network todo-net \
    todo-app:latest
# 1.2 For todo-db
docker container create \
    --name todo-db \
    --volume todo-db-vol:/var/lib/mysql \
    --env "MYSQL_ROOT_PASSWORD=todo" \
    --env "MYSQL_DATABASE=todo" \
    --env "MYSQL_USER=todo" \
    --env "MYSQL_PASSWORD=todo" \
    --network todo-net \
    library/mariadb:latest
    
# 2. Start the Docker Containers
docker container start todo-db
sleep 5s
docker container start todo-app
# end::provision[]

# tag::backup[]
# 1. Stop the Docker Containers
docker container stop todo-app todo-db

# 2. Backup the database
docker run --rm \
    --volumes-from todo-db \
    --volume $(pwd):/backup \
    alpine tar cvf /backup/backup.tar -C /var/lib/mysql .
    
# Start the Docker Containers
docker container start todo-db
sleep 5s
docker container start todo-app
# end::backup[]

# tag::restore[]
# 1. Stop the Docker Containers
docker container stop todo-app todo-db

# 2. Perform the restore
docker run --rm \
    --volumes-from todo-db \
    --volume $(pwd):/restore \
    alpine sh -c "rm -rf  /var/lib/mysql/* \
    && tar xvf /restore/backup.tar -C /var/lib/mysql --strip 1"
    
# 3. Start the Docker Containers 
docker container start todo-db
sleep 5s
docker container start todo-app
# end::restore[]

# tag::cleanup[]
# 1. Delete the Docker Containers
docker container rm -f todo-app todo-db

# 2. Delete the Docker Image
docker image rm todo-app

# 3. Delete the Docker Network
docker network rm todo-net

# 4. Delete the Docker Volume
docker volume rm todo-db-vol
# end::cleanup[]
