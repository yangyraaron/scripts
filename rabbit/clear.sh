#!/bin/bash

deployed_folder=/usr/local/rabbitmq_server-3.1.3
log=/var/log/rabbitmq
db=/var/lib/mnesia

echo "clearing..."
sudo rm -R $deployed_folder
sudo rm -R $log
sudo rm -R $db

echo "completed"