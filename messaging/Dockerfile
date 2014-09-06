# This file creates a container that runs Database (Percona) for Openstack on Docker
#
# Author: Paul Czarkowski
# Date: 08/16/2014

FROM dockenstack/base
MAINTAINER Paul Czarkowski "paul@paulcz.net"

RUN \
  echo 'deb http://www.rabbitmq.com/debian/ testing main' > /etc/apt/sources.list.d/rabbitmq.list && \
  wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc && \
  apt-key add rabbitmq-signing-key-public.asc && \
  apt-get -yqq update && \
  apt-get -yqq install rabbitmq-server && \
  rabbitmq-plugins enable rabbitmq_management

# Define mountable directories.
#VOLUME ["/etc/mysql", "/var/lib/mysql"]

ADD . /app

# Define working directory.
WORKDIR /app

RUN chmod +x /app/bin/*

# Define default command.
CMD ["/app/bin/boot"]

# Expose ports.
EXPOSE 5672 15672 4369

