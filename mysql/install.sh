#! /bin/bash

echo "install libaio1..."
sudo apt-get install libaio1

echo "add a mysql group..."
sudo groupadd mysql

echo "add  a account mysql into mysql group ..."
sudo useradd -g mysql mysql

echo "extracting the mysql file..."
dir_mysql_file=/usr/local/mysql-5.6.11
 
cd /usr/local

sudo mkdir $dir_mysql_file
sudo ln -s $dir_mysql_file mysql

tar zxvf ~/dev_softwares/mysql/mysql-5.6.11.tar.gz
sudo mv mysql-5.6.11-linux-glibc2.5-x86_64/* $dir_mysql_file
rm -r mysql-5.6.11-linux-glibc2.5-x86_64

cd mysql

root_dir=`pwd`

if [ $root_dir = /usr/local/mysql ]; then
	sudo chown -R mysql .
	sudo chgrp -R mysql .
fi	

echo "initializing the db"
sudo scripts/mysql_install_db --user=mysql 

echo "change the owner of the folder..."
if [ $root_dir = /usr/local/mysql ];then
 echo "setting owner of the folder"
 sudo chown -R root .
 sudo chown -R mysql data
fi

