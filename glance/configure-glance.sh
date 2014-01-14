#!/bin/sh

echo 'Glance: building config'

. /opt/openstack/etc/stackrc

sed -i "s/GLANCE_DBPASS/$GLANCE_DBPASS/" /etc/glance/*.conf
sed -i "s/GLANCE_DBSERVER/$DB_PORT_3306_TCP_ADDR/" /etc/glance/*.conf
sed -i "s/%SERVICE_TENANT_NAME%/glance/" /etc/glance/*.conf
sed -i "s/%SERVICE_USER%/glance/" /etc/glance/*.conf
sed -i "s/%SERVICE_PASSWORD%/$GLANCE_DBPASS/" /etc/glance/*.conf
sed -i "s/^auth_host = 127.0.0.1.*/auth_host = $KEYSTONE_PORT_35357_TCP_ADDR/" /etc/glance/*.conf
sed -i "s/GLANCE_PASS/$GLANCE_PASS/" /etc/glance/*.ini

mkdir -p /var/log/glance

echo 'Glance: configuring database'

glance-manage db_sync

export OS_SERVICE_TOKEN=$ADMIN_TOKEN

export OS_SERVICE_ENDPOINT=http://$KEYSTONE_PORT_35357_TCP_ADDR:35357/v2.0

echo 'Glance: Create keystone user / role'
keystone user-create --name=glance --pass=$GLANCE_PASS \
   --email=glance@example.com
keystone user-role-add --user=glance --tenant=service --role=admin

echo 'Glance: Create glance service'
keystone service-create --name=glance --type=image \
  --description="Glance Image Service"

IP=`cat /etc/hosts | head -n 1 | awk '{print $1}'`

SERVICE_ID=`keystone service-list | grep glance | awk {'print $2'}`

echo 'Glance: Create Identity endpoint'

keystone endpoint-create \
  --service-id=$SERVICE_ID \
  --publicurl=http://$IP:9292 \
  --internalurl=http://$IP:9292 \
  --adminurl=http://$IP:9292

touch /tmp/ready_to_start