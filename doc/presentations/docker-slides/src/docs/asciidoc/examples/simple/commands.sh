#!/bin/sh
# tag::build[]
# Build within the directory
docker image build -t simple:latest .

# Build with explicit given Dockerfile
docker image build -f $PWD/Dockerfile -t simple:latest $PWD
# end::build[]

# tag::volume[]
# Create Docker Volumes
docker volume create simple-1-vol
docker volume create simple-2-vol
# end::volume[]

# tag::container[]
# Create the docker containers
docker container create \
    --name simple-1 \
    -v simple-1-vol:/work \
    -e PREFIX=simple-1 simple
docker container create \
    --name simple-2 \
    -v simple-2-vol:/work \
    -e PREFIX=simple-2 \
    simple

# Start the Docker Containers
docker container start simple-1 simple-2

# Show Docker Containers logs
docker container logs simple-1
docker container logs simple-2

# Stop Docker Containers
docker container stop simple-1 simple-2

# Delete Docker Containers
docker container rm simple-1 simple-2
# end::container[]

# tag::cleanup[]
# 1. Delete Docker Containers with force
docker container rm -f simple-1 simple-2

# 2. Delete the Docker Image the Docker Containers where created from
docker image rm simple

# 3. Delete the Docker Volumes, used by the Docker Containers
docker volume rm simpl-1-vol simple-2-vol
# end::cleanup[]


docker container create \
    --name simple-1 \
    -v simple-1-vol:/work \
    -e PREFIX=simple simple
docker container create \
    --name simple-2 \
    -v simple-1-vol:/work \
    -e PREFIX=simple \
    simple