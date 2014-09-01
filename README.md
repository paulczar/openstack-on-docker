Openstack on Docker
=============

About
====

This project attempts to start the various openstack components inside docker containers running on CoreOS.

All settable config variables are stored in etcd under the `/openstack` namespace.   `confd` is used to create templates based on these.

* Support Services
* * MySQL ( using Percona and Galera Replication )
* * RabbitMQ ( not yet! )

* Openstack Services
* * Keystone
* * Glance

_currently unable to save glance images as public_

Using
====

## Start Vagrant based 3 node CoreOS cluster:

```
$ git clone https://github.com/paulczar/openstack-on-docker.git
$ vagrant up
$ vagrant ssh core-01
$ fleetctl load share/*/systemd/*
```

## Start Database

### Single node Database

If you really want to do just a single database,  edit `database/systemd/openstack-database-1.service` and remove `-e CLUSTER=openstack` from the command, then you can start it with the following:

```
$ fleetctl start openstack-database-1-data
$ fleetctl start openstack-database-1
```

### 2 node Database

Galera Replication, XtraBackup SST, Arbitor, Load Balancer

```
$ fleetctl start openstack-database-garbd
$ fleetctl start openstack-database-1-data
$ fleetctl start openstack-database-2-data
$ fleetctl start openstack-database-1
$ fleetctl start openstack-database-2
$ fleetctl start openstack-database-loadbalancer
```


## Start Openstack Services

```
$ fleetctl start openstack-glance-data
$ fleetctl start openstack-keystone
$ fleetctl start openstack-glance
$ fleetctl list-units
$ journalctl -f
```

```
$ docker run --rm -e HOST=172.17.8.101 paulczar/openstack-keystone /app/bin/catalog
Service: identity
+-------------+----------------------------------+
|   Property  |              Value               |
+-------------+----------------------------------+
|   adminURL  |  http://172.17.8.101:35357/v2.0  |
|      id     | 00835fb1c20d41d090c0494b18ea282a |
| internalURL |  http://172.17.8.101:5000/v2.0   |
|  publicURL  |  http://172.17.8.101:5000/v2.0   |
|    region   |            regionOne             |
+-------------+----------------------------------+

```

## Cleanup ##

```
vagrant destroy -f
```

# Special Thanks

To the [deis](http://deis.io) project.   I borrowed heavily from the methods they use to create and manage service discovery.

# License

Copyright 2014 Paul Czarkowski
Copyright 2013 OpDemand LLC
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# Authors

* Paul Czarkowski