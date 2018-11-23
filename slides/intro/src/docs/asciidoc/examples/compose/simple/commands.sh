#!/bin/bash
set -x
set -e

cd $(dirname ${0})

# tag::backup[]
# 1. Stop/Delete the Docker Containers
docker-compose down

# 2. Backup the database
# Be aware of the directory prefix!!!
docker run --rm \
    --volume simple_todo-db:/var/lib/mysql \
    --volume $(pwd):/backup \
    alpine tar cvf /backup/backup.tar -C /var/lib/mysql .
    
# Create/Start the Docker Containers
docker-compose up -d
# end::backup[]

# tag::restore[]
# 1. Stop/Delete the Docker Containers
docker-compose down

# 2. Perform the restore
# Be aware of the directory prefix!!!
docker run --rm \
    --volume simple_todo-db:/var/lib/mysql \
    --volume $(pwd):/restore \
    alpine sh -c "rm -rf  /var/lib/mysql/* \
    && tar xvf /restore/backup.tar -C /var/lib/mysql --strip 1"
    
# 3. Create/Start the Docker Containers 
docker-compose up -d
# end::restore[]

# tag::cleanup[]
# Stop/Delete the Docker Containers as well as the Docker Volume
docker-compose down -v
# end::cleanup[]

# Nothing else