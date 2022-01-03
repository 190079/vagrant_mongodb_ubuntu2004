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
use CODEJOURNEY;
db.createUser({ 
user: 'cjadmin',
pwd: 'admin123',
roles: [
    { role: "readWrite",   db: "CODEJOURNEY" }
    ]
});
EOF


echo "######## changing mongo config ###########"
rm /etc/mongod.conf
sudo cp config/mongod.conf /etc/mongod.conf
echo "####### Restarting mongo ###############"
sudo systemctl restart mongod
