FROM java:openjdk-8-jdk-alpine
MAINTAINER <thomas.herzog@gepardec.com>
LABEL name="ToDo application" \
      run="docker run --name <container-name> -p 8080:8080 -e VIRTUAL_HOST=<virt-host> -e DB_USER=<db-user> -e DB_PASSWORD=<db-pwd> -e DB_URL=<db-url> --network <network-name> <image-name>"
      
RUN mkdir /work
COPY app.jar /work/app.jar

CMD ["java", "-jar", "/work/app.jar", "-Djava.net.preferIPv4Stack=true"]