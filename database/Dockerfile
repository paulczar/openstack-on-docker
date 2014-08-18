# This file creates a container that runs MariaDB for Openstack on Docker
#
# Author: Paul Czarkowski
# Date: 08/16/2014

FROM dockenstack/base
MAINTAINER Paul Czarkowski "paul@paulcz.net"

RUN \
  apt-get update && \
  apt-get -yqq install lsb-release && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0xcbcb082a1bb943db && \
  echo "deb http://mariadb.mirror.iweb.com/repo/10.0/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/mariadb.list && \
  ln -fs /bin/true /usr/bin/chfn && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server && \
  sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
  echo "mysqld_safe &" > /tmp/config && \
  echo "sleep 5" >> /tmp/config && \
  echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\";'" >> /tmp/config && \
  bash /tmp/config && \
  rm -f /tmp/config

# Define mountable directories.
VOLUME ["/data", "/etc/mysql", "/var/lib/mysql"]

# Define working directory.
WORKDIR /data

ADD . /app

RUN chmod +x /app/bin/*

# Define default command.
CMD ["/app/bin/boot"]

# Expose ports.
EXPOSE 3306