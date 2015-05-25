Openstack on Docker
===================

About
-----

This is a slowly evolving attempt to run openstack services inside docker containers using the `coreos` ecosystem for scheduling and service discovery.

Currently supports Keystone and Glance.


Using:
------

### Development Environment

Start Vagrant and load up the fleet units for Dockenstack.

```
$ vagrant up
$ vagrant ssh core-01
$ fleetctl submit share/fleet/units/*
```

Start up our support containers and wait until the registry is running:

```
$ fleetctl start registry registrator-etcd registrator-skydns skydns
Triggered global unit registry.service start
Triggered global unit cadvisor.service start
Triggered global unit registrator.service start
$ journalctl -f -u registry.service
-- Logs begin at Sun 2015-05-24 17:52:40 UTC. --
...
...
May 24 17:55:49 core-01 systemd[1]: Started Docker Registry 2.0.
May 24 17:55:49 core-01 sh[1757]: time="2015-05-24T17:55:49.964104241Z" level=info msg="debug server listening localhost:5001"
```

Build our base image and wait until it finishes building:

```
$ fleetctl start openstack-build@base.service && \
  journalctl -f -u openstack-build@base.service
-- Logs begin at Sun 2015-05-24 17:52:40 UTC. --
May 24 17:56:24 core-01 systemd[1]: Starting build service for dockenstack base image...
May 24 17:56:24 core-01 sh[1831]: Sending build context to Docker daemon 3.072 kB
May 24 17:56:24 core-01 sh[1831]: Sending build context to Docker daemon
...
...
May 24 17:59:46 core-01 docker[6164]: c73d1826dce1: Image already exists
May 24 17:59:46 core-01 systemd[1]: Started build service for dockenstack base image.
```

Build our images: ( or download them from public registry )

```
$ fleetctl start openstack-build@database.service
$ fleetctl start openstack-build@rabbitmq.service
$ fleetctl start openstack-build@keystone.service
$ fleetctl start openstack-build@glance.service
```

Start up our openstack services:

```
$ fleetctl start openstack-database-data@1.service
$ fleetctl start openstack-database@1.service
$ fleetctl start openstack-rabbitmq@1.service
$ fleetctl start openstack-keystone@1.service
$ fleetctl start openstack-glance@1.service
```

Test it out:

```
$ docker exec -ti openstack-glance-1 bash
$ source /app/openrc
$ keystone catalog
$ wget -O /tmp/cirros.img http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img
$ glance image-create --name "cirros" --disk-format qcow2 \
  --container-format bare --is-public True --progress < /tmp/cirros.img
```

Author(s)
======

Paul Czarkowski (paul@paulcz.net)

License
=======

Copyright 2015 Paul Czarkowski

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
