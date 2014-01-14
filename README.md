# Openstack on Docker

# About

This project attempts to start the various openstack components inside docker containers.

* Uses docker's new[ish] naming and link features ( developed on 0.7.2 )
* wrapper scripts to build / start containers
* Currently working : Keystone,  Glance

# Using

```
git clone https://github.com/paulczar/openstack-on-docker.git
cd openstack-on-docker
bin/build_all
bin/start_all

source ./openrc
keystone catalog
wget -O /tmp/cirros.img http://cdn.download.cirros-cloud.net/0.3.1/cirros-0.3.1-x86_64-disk.img
glance image-create --name=test --disk-format=qcow2 --container-format=bare --is-public=true < /tmp/cirros.img
glance image-list

bin/destroy

```

## Cleanup ##

```
docker kill openstack-mysql openstack-glance openstack-
```

# License

Apache 2

# Authors

* Paul Czarkowski