#!/bin/bash

folder=rabbitmq-server-generic-unix-3.1.3
target_folder=rabbitmq_server-3.1.3
deployed_folder=/usr/local
a_folder=$deployed_folder/$target_folder
url=http://www.rabbitmq.com/releases/rabbitmq-server/v3.1.3/$folder.tar.gz
log_folder=var/log/rabbitmq
p_db_folder=var/lib/mnesia

echo "downloading..."
#wget $url

echo "creating user and group..."
sudo groupadd rabbitmq
sudo useradd -g rabbitmq rabbitmq

echo "extracting..."
tar xzvf  $folder.tar.gz
sudo mv -f $target_folder $a_folder

cd $a_folder

sudo mkdir -p $log_folder
sudo mkdir -p $p_db_folder/rabbit

sudo chown -R rabbitmq:rabbitmq $log_folder 
sudo chown -R rabbitmq:rabbitmq $p_db_folder

sudo chmod -R 775 $log_folder
sudo chmod -R 775 $p_db_folder

sudo chown -R rabbitmq:rabbitmq $a_folder
sudo chmod -R 775 $a_folder

echo "completed"
