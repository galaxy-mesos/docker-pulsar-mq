# Download base image ubuntu 16.04
FROM ubuntu:16.04

# Define the ENV variable
ENV container docker
ARG DEBIAN_FRONTEND=noninteractive
# Install pulsar, kombu, rabbitMQ
RUN apt-get update
RUN apt-get install -y apt-utils vim
RUN apt-get install -y python-dev python-pip
RUN pip install --upgrade pip
RUN pip install virtualenv
RUN mkdir -p /pulsar
RUN virtualenv /pulsar/venv
RUN . /pulsar/venv/bin/activate; pip install pulsar-app kombu
#RUN . /pulsar/venv/bin/activate; pip install kombu
RUN . /pulsar/venv/bin/activate; pulsar-config -c /pulsar --mq

# Avoid message: invoke-rc.d: policy-rc.d denied execution of start.
RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d

RUN apt-get install -y rabbitmq-server

# Configure Port
EXPOSE 8913 5672

# CMD cd pulsar
CMD . /pulsar/venv/bin/activate; pulsar --daemon
