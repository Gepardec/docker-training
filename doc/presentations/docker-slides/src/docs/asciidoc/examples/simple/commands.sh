#!/bin/sh
# tag::build[]
# Build the Docker Image
# Build within the directory
docker image build --tag simple:latest .

# Build with explicit given Dockerfile
docker image build --file $PWD/Dockerfile -t simple:latest $PWD
# end::build[]

# tag::volume[]
# Create Docker Volumes
# Create Docker Volume for first container
docker volume create simple-1-vol
# Create Docker Volume for second container
docker volume create simple-2-vol
# end::volume[]

# tag::container[]
# 1. Create the Docker Containers
docker container create \
    --name simple-1 \
    --volume simple-1-vol:/work \
    --env PREFIX=simple-1 simple:latest
docker container create \
    --name simple-2 \
    --volume simple-2-vol:/work \
    --env PREFIX=simple-2 \
    simple:latest

# 2. Start the Docker Containers
docker container start simple-1 simple-2

# 3. Show Docker Containers logs
sleep 5s
docker container logs simple-1
docker container logs simple-2

# 4. Stop Docker Containers
docker container stop simple-1 simple-2
# end::container[]

# tag::cleanup[]
# 1. Delete Docker Containers with force
docker container rm -f simple-1 simple-2

# 2. Delete the Docker Image the Docker Containers where created from
docker image rm simple

# 3. Delete the Docker Volumes, used by the Docker Containers
docker volume rm simple-1-vol simple-2-vol
# end::cleanup[]