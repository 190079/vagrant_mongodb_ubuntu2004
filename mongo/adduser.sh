#!/bin/bash
echo "################# Adding users ###########"
mongosh <<EOF
use admin;
db.createUser({ 
user: 'admin',
pwd: 'admin',
roles: [
    { role: "userAdminAnyDatabase", db: "admin" },
    { role: "readWriteAnyDatabase", db: "admin" },
    { role: "dbAdminAnyDatabase",   db: "admin" }
    ]
});
EOF

mongosh <<EOF
use TECHCHAD;
db.createUser({ 
user: 'techchad',
pwd: 'admin',
roles: [
    { role: "readWrite",   db: "TECHCHAD" }
    ]
});
EOF


echo "######## changing mongo config ###########"
touch mongo.conf
echo "# mongod.conf
# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# Where and how to store data.
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true
#  engine:
#  wiredTiger:

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

# network interfaces
net:
  port: 27017
  bindIp: 0.0.0.0


# how the process runs
processManagement:
  timeZoneInfo: /usr/share/zoneinfo


security:
  authorization: enabled
#operationProfiling:

#replication:

#sharding:

## Enterprise-Only Options:

#auditLog:

#snmp:
" > mongod.conf

rm /etc/mongod.conf
sudo cp mongod.conf /etc/mongod.conf

echo "####### Restarting mongo ###############"
sudo systemctl restart mongod
