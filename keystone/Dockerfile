# Creates openstack common base image
#
# Author: Paul Czarkowski
# Date: 08/11/2013


FROM openstack/common
MAINTAINER Paul Czarkowski "paul@paulcz.net"

RUN git clone --depth 1 -b stable/havana https://github.com/openstack/keystone.git /opt/openstack/keystone

RUN cd /opt/openstack/keystone && python setup.py install

RUN apt-get -yqq install python-keystoneclient

ADD keystone-paste.ini /etc/keystone/keystone-paste.ini
ADD keystone.conf /etc/keystone/keystone.conf
ADD start-keystone.sh /opt/openstack/keystone/bin/start-keystone.sh
ADD configure-keystone.sh /opt/openstack/keystone/bin/configure-keystone.sh

RUN chmod +x /opt/openstack/keystone/bin/*.sh

EXPOSE 5000 35357

CMD ["/opt/openstack/keystone/bin/start-keystone.sh"]
