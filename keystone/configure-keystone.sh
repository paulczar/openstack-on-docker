#!/bin/sh

echo 'Keystone: building config'

. /opt/openstack/etc/stackrc

sed -i "s/KEYSTONE_DBPASS/$KEYSTONE_DBPASS/" /etc/keystone/keystone.conf
sed -i "s/KEYSTONE_DBSERVER/$DB_PORT_3306_TCP_ADDR/" /etc/keystone/keystone.conf
sed -i "s/^# admin_token = ADMIN/admin_token = $ADMIN_TOKEN/" /etc/keystone/keystone.conf

mkdir -p /var/log/keystone

echo 'Keystone: configuring database'

keystone-manage db_sync

echo 'Keystone: configuring pki'
keystone-manage pki_setup --keystone-user root --keystone-group root

touch /tmp/ready_to_start

while true
do
  curl http://127.0.0.1:35357/v2.0  > /dev/null 2> /dev/null && break
  sleep 1
done

export OS_SERVICE_TOKEN=$ADMIN_TOKEN

export OS_SERVICE_ENDPOINT=http://127.0.0.1:35357/v2.0

echo 'Keystone: Create Tenant - Admin'
keystone tenant-create --name=admin --description="Admin Tenant"

echo 'Keystone: Create Tenant - Service'
keystone tenant-create --name=service --description="Service Tenant"

echo 'Keystone: Create User - Admin'
keystone user-create --name=admin --pass=$ADMIN_PASS --email=admin@example.com

echo 'Keystone: Create Role - Admin'
keystone role-create --name=admin

echo 'Keystone: Add Admin user to Admin Role in Admin tenant'
keystone user-role-add --user=admin --tenant=admin --role=admin

echo 'Keystone: Create identity service'
keystone service-create --name=keystone --type=identity \
  --description="Keystone Identity Service"

IP=`cat /etc/hosts | head -n 1 | awk '{print $1}'`

SERVICE_ID=`keystone service-list | grep keystone | awk {'print $2'}`

echo 'Keystone: Create Identity endpoint'

keystone endpoint-create \
  --service-id=$SERVICE_ID \
  --publicurl=http://$IP:5000/v2.0 \
  --internalurl=http://$IP:5000/v2.0 \
  --adminurl=http://$IP:35357/v2.0
