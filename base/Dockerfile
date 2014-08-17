# Creates openstack common base image
#
# Author: Paul Czarkowski
# Date: 08/16/2014


FROM ubuntu:12.04
MAINTAINER Paul Czarkowski "paul@paulcz.net"

ENV DEBIAN_FRONTEND noninteractive

# Base Deps
RUN apt-get update && apt-get install -yq \
    make \
    ca-certificates \
    net-tools \
    sudo \
    wget \
    vim \
    strace \
    lsof \
    netcat \
    --no-install-recommends

# Openstack Deps
RUN apt-get -yqq install curl git bzip2 python-dev libxml2-dev libxslt1-dev \
    zlib1g-dev libreadline-dev libmysqlclient-dev libsqlite3-dev libdb-dev python-mysqldb \
    build-essential mysql-client --no-install-recommends

# generate a local to suppress warnings
RUN locale-gen en_US.UTF-8

ADD https://bootstrap.pypa.io/get-pip.py /tmp/get-pip.py

RUN python /tmp/get-pip.py

# download latest stable etcdctl
ADD https://s3-us-west-2.amazonaws.com/opdemand/etcdctl-v0.4.5 /usr/local/bin/etcdctl
RUN chmod +x /usr/local/bin/etcdctl

# install confd
ADD https://s3-us-west-2.amazonaws.com/opdemand/confd-v0.5.0-json /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd