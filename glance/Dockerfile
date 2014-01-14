# Creates openstack common base image
#
# Author: Paul Czarkowski
# Date: 08/11/2013


FROM openstack/common
MAINTAINER Paul Czarkowski "paul@paulcz.net"

RUN git clone --depth 1 -b stable/havana https://github.com/openstack/glance.git /opt/openstack/glance

RUN cd /opt/openstack/glance && python setup.py install

RUN apt-get -yqq install python-keystoneclient

ADD etc /etc/glance
ADD configure-glance.sh /opt/openstack/glance/bin/configure-glance.sh
ADD start-glance.sh /opt/openstack/glance/bin/start-glance.sh

RUN chmod +x /opt/openstack/glance/bin/*.sh

EXPOSE 5000 35357

CMD ["/opt/openstack/glance/bin/start-glance.sh"]
