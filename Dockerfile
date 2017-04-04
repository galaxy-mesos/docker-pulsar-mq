# Download base image ubuntu 14.04
FROM ubuntu:14.04

# Define the ENV variable
ENV container docker

# Install pulsar, kombu, rabbitMQ
#RUN apt-get update && apt-get install -y rabbitmq-server python-pip
RUN apt-get update && apt-get install -y python-pip
RUN pip install pulsar-app
RUN pulsar-config --mq
RUN pip install kombu

# Configure Port
EXPOSE 8913 5672

CMD pulsar --daemon
