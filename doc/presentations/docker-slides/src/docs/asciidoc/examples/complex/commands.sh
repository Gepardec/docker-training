# tag::build[]
# Build the todo-app Docker Image
docker image build -t todo-app:latest .
# end::build[]

# tag::volume[]
docker volume create todo-db-vol
# end::volume[]

# tag::network[]
docker network create todo-net
# end::network[]

# tag::provision[]
# Create todo-app Docker Container
docker container create \
    --name todo-app \
    --env "DB_URL=jdbc:mysql://todo-db:3306/todo" \
    --env "DB_USER=todo" \
    --env "DB_PASSWORD=todo" \
    --env "VIRTUAL_HOST=todo-app.127.0.0.1.xip.io" \
    --publish 8080:8080 \
    --network todo-net \
    todo-app:latest
# Create todo-db Docker Container
docker container create \
    --name todo-db \
    --volume todo-db-vol:/var/lib/mysql \
    --env "MYSQL_ROOT_PASSWORD=todo" \
    --env "MYSQL_DATABASE=todo" \
    --env "MYSQL_USER=todo" \
    --env "MYSQL_PASSWORD=todo" \
    --network todo-net \
    library/mariadb:latest
    
# Start todo-db Docker Container
docker container start todo-db
# Sleep for 5 seconds
sleep 5s
# Start todo-app Docker Container
docker container start todo-app
# end::provision[]

# tag::cleanup[]
#docker container rm -f todo-app todo-db
#docker image rm todo-app
#docker network rm todo-net
#docker volume rm todo-db-vol
# end::cleanup[]
