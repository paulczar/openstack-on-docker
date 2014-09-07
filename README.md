Openstack on Docker
=============

About
====

This project attempts to start the various openstack components inside docker containers running on CoreOS.

All settable config variables are stored in etcd under the `/openstack` namespace.   `confd` is used to create templates based on these.

* Support Services
* * MySQL ( using Percona and Galera Replication )
* * RabbitMQ ( not clustered ... yet )

* Openstack Services
* * Keystone
* * Glance

_currently unable to save glance images as public_

Download
=======

```
$ git clone https://github.com/paulczar/openstack-on-docker.git
$ cd openstack-on-docker
```

Single Node system
============

edit `config.rb` and set `$num_instances=1` and `$vb_memory = 4000` and then bring the VM up and login to it:

```
$ vagrant up
$ vagrant ssh core-01
```

Load up the systemd units:

```
$ fleetctl load share/database/openstack-database-1*
$ fleetctl load share/database/openstack-database-loadbalancer
$ fleetctl load share/messaging/openstack-messaging-1
$ fleetctl load share/keystone/*
$ fleetctl load share/glance/*
```

Start the database and messaging:

```
$ fleetctl start openstack-database-1-data
$ fleetctl start openstack-database-1
$ fleetctl start openstack-messaging-1
$ watch -n 1 fleetctl list-units
```

Watch the systems come online with fleet.  Once they are then bring up the next set:

```
$ fleetctl start openstack-glance-data
$ fleetctl start openstack-database-loadbalancer
$ fleetctl start openstack-keystone
$ fleetctl start openstack-glance
```

## Start Vagrant based 3 node CoreOS cluster:

```
$ vagrant ssh core-01
$ fleetctl load share/*/systemd/*
```

## Start Database

Galera Replication, XtraBackup SST, Arbitor, Load Balancer:

```
$ fleetctl start openstack-database-1-data
$ fleetctl start openstack-database-2-data
$ fleetctl start openstack-database-3-data
$ fleetctl start openstack-database-1
```

This will kick off the first node in the db cluster.   Wait until it is `active` by running `watch fleetctl list-units` before proceeding:

```
$ fleetctl start openstack-database-2
$ fleetctl start openstack-database-3
$ fleetctl start openstack-database-loadbalancer
```

_if you don't want to run 3 databases you can run `openstack-database-garbd` instead of the third._

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