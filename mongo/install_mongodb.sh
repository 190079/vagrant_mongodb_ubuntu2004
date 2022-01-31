#!/bin/bash
function update(){
	echo "####################### Upgrading repo #################"
	sudo apt update;
	sudo apt upgrade -y;
}

function adding_keys(){
	echo "####################### Adding repo keys #################"
	wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -;
	echo "####################### Installing gnupg #################";
	sudo apt install wget gnupg -y;
	echo "####################### Adding MongoDB list #################"
	echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
	update
}
function install_mongodb(){
	echo "####################### Installing MongoDB #################"
	sudo apt-get install -y mongodb-org=5.0.2 mongodb-org-database=5.0.2 mongodb-org-server=5.0.2 mongodb-org-shell=5.0.2 mongodb-org-mongos=5.0.2 mongodb-org-tools=5.0.2
	echo "####################### Starting MongoDB Service #################"
	sudo systemctl enable --now mongod;
}

update
adding_keys
install_mongodb