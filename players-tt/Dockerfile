FROM nginx:latest

RUN apt-get update
RUN apt-get install -y wget unzip

WORKDIR /usr/share/nginx/html
COPY downloadArtifact.sh  /tmp
RUN rm -rf /usr/share/nginx/html/*
RUN /tmp/downloadArtifact.sh

RUN rm /tmp/downloadArtifact.sh
RUN apt-get remove -y wget unzip


# Set environment variables
ENV PRODUCTION="true"
ENV MQTT_SERVER="alpha"
ENV MQTT_PROTOCOL="ws"
ENV MQTT_PORT="9001"
ENV MQTT_PATH=""


# Replace variables in env.js
RUN envsubst < ./assets/env.template.js > ./assets/env.js

