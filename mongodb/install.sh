#!/bin/bash

des_dir=/usr/local
profile=~/.bashrc
db=/var/mongodb/data/db

# curl -O http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.4.8.tgz

# tar -zxvf mongodb-linux-x86_64-2.4.8.tgz

echo "copying files ..."
sudo mkdir $des_dir
sudo cp -R -n mongodb-linux-x86_64-2.4.8 $des_dir

echo -e "\nexport PATH=\$PATH:$des_dir/mongodb-linux-x86_64-2.4.8/bin">>$profile

echo "creating user and group ..."
sudo groupadd mongodb
sudo useradd -g mongodb mongodb

#sudo usermod -a -G mongodb wisedulab2

sudo mkdir -p $db
sudo chown -R mongodb:mongodb $db