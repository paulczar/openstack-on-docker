# Creates openstack common base image
#
# Author: Paul Czarkowski
# Date: 08/11/2013

FROM paulczar/openstack-base
MAINTAINER Paul Czarkowski "paul@paulcz.net"

RUN git clone --depth 1 -b stable/icehouse https://github.com/openstack/keystone.git /opt/openstack/keystone

RUN cd /opt/openstack/keystone && python setup.py install

# I don't even...
RUN pip install -r /opt/openstack/keystone/requirements.txt

RUN mkdir -p /etc/keystone && chmod 0700 /etc/keystone

EXPOSE 5000 35357

ADD . /app

RUN chmod +x /app/bin/*

CMD ["/app/bin/boot"]
