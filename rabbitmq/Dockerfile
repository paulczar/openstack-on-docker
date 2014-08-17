# This file creates a container that runs RabbitMQ for Openstack
# Date: 08/16/2014

FROM paulczar/openstack-base
MAINTAINER Paul Czarkowski "paul@paulcz.net"

RUN apt-get -yqq install rabbitmq-server

add . /opt/openstack/rabbitmq

EXPOSE 5672

CMD['/opt/openstack/rabbitmq/start_rabbitmq.sh']



