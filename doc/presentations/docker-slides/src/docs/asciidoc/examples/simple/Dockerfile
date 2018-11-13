FROM library/alpine:3.6
MAINTAINER Thomas Herzog <thomas.herzog@gepardec.com>

LABEL name="Simple docker example" \
      run="docker run -v simple-volume:/work <image-name>"
      
RUN mkdir /work
WORKDIR /work
VOLUME /work
ENV PREFIX "default"
CMD ["/bin/sh", \
     "-c", \
     "while true; do sleep 3s; COUNT=${COUNT:-1}; \
        touch /work/${PREFIX}_${COUNT}; ls /work -lrta; \
        COUNT=$((COUNT+1)); \
      done"]

