# This file creates a container that runs MySQL Server
#
# Author: Paul Czarkowski
# Date: 08/04/2013

FROM openstack/common
MAINTAINER Paul Czarkowski "paul@paulcz.net"

RUN apt-get -yqq install mysql-server

ADD . /opt/openstack/mysql

ADD mysql-listen.cnf /etc/mysql/conf.d/

RUN chmod +x /opt/openstack/mysql/*.sh

EXPOSE 3306

# Start mysql server
CMD ["/opt/openstack/mysql/start_mysql.sh"]

