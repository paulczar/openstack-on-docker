# Creates openstack common base image
#
# Author: Paul Czarkowski
# Date: 08/19/2014

FROM dockenstack/base
MAINTAINER Paul Czarkowski "paul@paulcz.net"

RUN git clone --depth 1 -b stable/icehouse https://github.com/openstack/glance.git /opt/openstack/glance

RUN cd /opt/openstack/glance && python setup.py install

# I don't even...
RUN pip install -r /opt/openstack/glance/requirements.txt

RUN pip install python-glanceclient

RUN mkdir -p /etc/glance && mkdir -p /var/lib/glance/images && mkdir -p /var/log/glance

ADD . /app

RUN chmod +x /app/bin/*

EXPOSE 9191
EXPOSE 9292

CMD ["/app/bin/boot"]
