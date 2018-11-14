FROM java:openjdk-8-jdk-alpine
MAINTAINER <thomas.herzog@gepardec.com>
LABEL name="ToDo application" \
      run="docker run --name <container-name> --publish 8080:8080 \
           --env DB_USER=<db-user> --env DB_PASSWORD=<db-pwd> \
           --env DB_URL=<db-url> --network <network-name> <image-name>"
      
RUN mkdir /work
COPY app.jar /work/app.jar
#, "-Djava.net.preferIPv4Stack=true"
CMD ["java", "-jar", "/work/app.jar", \
     "java.net.preferIPv4Stack=true", \
     "-Dswarm.bind.address=0.0.0.0"]