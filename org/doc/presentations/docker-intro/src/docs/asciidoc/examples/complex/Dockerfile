FROM java:openjdk-8-jdk-alpine
MAINTAINER <thomas.herzog@gepardec.com>
LABEL name="ToDo application" \
      create="docker container create --name <container-name> --publish <exposed-port>:8080 \
           --env DB_USER=<db-user> --env DB_PASSWORD=<db-pwd> \
           --env DB_URL=<db-url> --network <network-name> <image-name>" \
      start="docker container start <container-name>"
      
RUN mkdir /work
COPY app.jar /work/app.jar
CMD ["java", "-jar", "/work/app.jar", "java.net.preferIPv4Stack=true","-Dswarm.bind.address=0.0.0.0"]