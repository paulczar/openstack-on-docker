# Creates openstack common base image
#
# Author: Paul Czarkowski
# Date: 08/11/2013


FROM stackbrew/ubuntu:precise
MAINTAINER Paul Czarkowski "paul@paulcz.net"

RUN apt-get -yqq update

RUN apt-get -yqq install curl wget git bzip2 python-dev python-pip libxml2-dev libxslt1-dev \
      zlib1g-dev libreadline-dev libmysqlclient-dev libsqlite3-dev libdb-dev python-mysqldb \
      mysql-client

RUN pip install distribute --upgrade
RUN pip install lxml pbr d2to1 mysql-python

RUN mkdir -p /opt/openstack/etc

CMD ["bash"]
