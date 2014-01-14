#!/bin/sh

. /opt/openstack/etc/stackrc

while true
do
  mysql -uroot -AN -e "select now();" 2> /dev/null && break
  sleep 1
done

mysqladmin -uroot password $MYSQL_PASS
mysqladmin -uroot -p$MYSQL_PASS create keystone

mysql -uroot -p$MYSQL_PASS -AN -e "DROP DATABASE test;"

mysql -uroot -p$MYSQL_PASS -AN -e "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
IDENTIFIED BY '$KEYSTONE_DBPASS';"

mysql -uroot -p$MYSQL_PASS -AN -e "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
IDENTIFIED BY '$KEYSTONE_DBPASS';"

mysql -uroot -p$MYSQL_PASS -AN -e "flush privileges"