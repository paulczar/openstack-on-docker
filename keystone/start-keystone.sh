#!/bin/sh

. /opt/openstack/etc/stackrc

echo -n 'waiting for MySQL to be ready '
while true
do
  mysql -h $DB_PORT_3306_TCP_ADDR -ukeystone -p$KEYSTONE_DBPASS -AN -e "select now();" > /dev/null 2> /dev/null && break
  echo -n "."
  sleep 1
done

echo 'OK'

/opt/openstack/keystone/bin/configure-keystone.sh &

while true
do
  [ -f /tmp/ready_to_start ] && break
  sleep 1
done

echo 'Starting Keystone'
/opt/openstack/keystone/bin/keystone-all
