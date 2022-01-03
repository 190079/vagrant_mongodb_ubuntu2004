#!/bin/bash
function install_upgrade()
{
    sudo apt-get update
    sudo apt-get upgrade -y 
}
function install_mongo(){
    echo "############# Installing mongo repo#########"
    wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
    sudo apt-get install gnupg -y
    wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
    echo "###################Adding repo ##############"
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
    echo "############# mongo install #########"
    install_upgrade
    sudo apt -y install mongodb-org
    echo "mongodb-org hold" | sudo dpkg --set-selections
    echo "mongodb-org-database hold" | sudo dpkg --set-selections
    echo "mongodb-org-server hold" | sudo dpkg --set-selections
    echo "mongodb-org-shell hold" | sudo dpkg --set-selections
    echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
    echo "mongodb-org-tools hold" | sudo dpkg --set-selections
    echo "############# Starting mongodb #########"
    sudo systemctl enable --now mongod
}
echo "############# Installing Updates#########"
install_upgrade
sudo apt install wget git -y
echo "############# Installing mongodb#########"
install_mongo
sudo systemctl restart mongod
