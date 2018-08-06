# Docker training

## Checkout this project

```
$ git clone --recurse-submodules https://github.com/Gepardec/docker-training.git
```

## Docker info

```
$ docker info
```

More info about engine and client
```
$ docker version
```

## Run, Start, Stop...

```
$ docker ps
$ docker pull alpine
$ docker image ls
$ docker run alpine echo “hello from alpine”
$ docker run alpine ls -l
$ docker ps -a
$ docker start CONTAINER
$ docker container rm CONTAINER
```

Try another command.
```
$ docker run alpine /bin/sh
```

Not working? 
You need to attach an interactive tty in the container with the `-it` flags.
```
$ docker run -it alpine /bin/sh
```

## Docker Registry

### Run a registry

```
$ docker run -d -p 5000:5000 --rm --name registry registry:2
```

### Tag and push an image
```
$ docker pull alpine
$ docker image tag alpine localhost:5000/myalpine:custom
$ docker push localhost:5000/myalpine:custom
```

Remove local images and containers using the images
```
$ docker image rm -f alpine
$ docker image rm -f localhost:5000/myalpine:custom
```

Pull the new image from local registry
```
$ docker pull localhost:5000/myalpine:custom
$ docker run --rm localhost:5000/myalpine:custom ls -l
```

### Commit and push an image
Start a simple container
```
$ docker run --name myalpine -it localhost:5000/myalpine:custom /bin/sh
```

Make some changes inside the container
```
$ cd
$ touch file.txt
```

Commit and push the container
```
$ docker commit myalpine localhost:5000/myalpine:file
$ docker run --rm localhost:5000/myalpine:file ls -l /root
```

Commit a container with new `CMD`
```
$ docker commit --change='CMD ["ls", "-l", "/root"]' myalpine localhost:5000/myalpine:cmd
$ docker run --rm localhost:5000/myalpine:cmd
```

### Inspect image history

```
$ docker history localhost:5000/myalpine:file
```

## Network

Let's start something more interesting.
```
$ docker run --name mariadb -p 3306:3306 -e MYSQL_ROOT_PASSWORD=super-secret-pw -e MYSQL_DATABASE=todo -e MYSQL_USER=todo -e MYSQL_PASSWORD=todo --rm -d mariadb
```

How to connect other containers?

```
$ docker network create example
$ docker network connect --alias db example mariadb
$ docker run --rm -p 8080:8080 --network example adrianfarmadin/todo-jsf-example
$ docker run --network example -p 8090:8080 -d adminer
```

Inspect containers default aliases.

## Volumes
Why volumes?
* Selinux: chcon -Rt svirt_sandbox_file_t /my/own/datadir 
* Filesystem UserId/GroupId


```
$ docker volume create db-vol
$ docker volume ls
$ docker volume inspect db-vol
```

Use volume
```
$ docker run --name mariadb  --mount source=db-vol,target=/var/lib/mysql -e MYSQL_ROOT_PASSWORD=super-secret-pw -e MYSQL_DATABASE=todo -e MYSQL_USER=todo -e MYSQL_PASSWORD=todo --network example --net-alias db --rm -d mariadb
```

or
```
$ docker run --name mariadb  -v db-vol:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=super-secret-pw -e MYSQL_DATABASE=todo -e MYSQL_USER=todo -e MYSQL_PASSWORD=todo --network example --net-alias db --rm -d mariadb
```

### Backup a container

```
$ docker run --rm --volumes-from mariadb -v $(pwd):/backup alpine tar cvf /backup/backup.tar -C /var/lib/mysql .
```

Restore container from backup
```
$ docker volume create db-vol2
$ docker run -v db-vol2:/dbdata -v $(pwd):/backup alpine sh -c "cd /dbdata && tar xvf /backup/backup.tar --strip 1"
$ docker run --name mariadb  -v db-vol2:/var/lib/mysql --network example --net-alias db --rm -d mariadb
```

Docker volumes are not deleted with container. You muss clean up yourself.
```
$ docker volume rm my-vol
```

## Clean up

```
$ docker kill $(docker ps -q)
$ docker container prune
$ docker volume prune
$ docker network prune
```

or delete everything

```
$ docker system prune
```


## Docker-compose

Only windows users
```
$ $Env:COMPOSE_CONVERT_WINDOWS_PATHS=1
```

Run example app

```
$ docker-compose up -d
$ docker-compose logs -f web
$ docker-compose down
```

## Dockerfile

```
$ docker build -t todo .
```

## Exercises

### Change todo list name

Todo app accept `todo.owner` system-property to change todo list owner name. Pass it to as a command line argument.

> In java you pass system-property as `-Dname=value` command line argument.

### Link multiple docker-compose files

Create new stage/docker-compose.yml with your `todo` image und start it.

```
$ docker-compose -f stage/docker-compose.yml up
```

Can you connect your new instance with `nginx-proxy` from `docker-compose.yml` file?