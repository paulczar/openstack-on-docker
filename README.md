# Openstack on Docker

# About

This project attempts to start the various openstack components inside docker containers running on CoreOS

* Currently working : Keystone

# Using

```
$ git clone https://github.com/paulczar/openstack-on-docker.git
$ vagrant up
$ vagrant ssh
$ fleetctl load share/*/systemd/*
$ fleetctl start openstack-database-data
$ fleetctl start openstack-glance-data
$ fleetctl start openstack-database
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