# This file creates a container that runs RabbitMQ for Openstack
#
# Author: Paul Czarkowski
# Date: 08/04/2013


FROM openstack/common
MAINTAINER Paul Czarkowski "paul@paulcz.net"

RUN apt-get -yqq install rabbitmq-server

add . /opt/openstack/rabbitmq

EXPOSE 5672

CMD['/opt/openstack/rabbitmq/start_rabbitmq.sh']



