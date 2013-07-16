#!/bin/bash

ctl=/usr/local/rabbitmq_server-3.1.3/sbin/rabbitmqctl
server=/usr/local/rabbitmq_server-3.1.3/sbin/rabbitmq-server

master=rabbit@$HOSTNAME
node=rabbit_2@$HOSTNAME

echo "stopping and resetting..."
$ctl -n $node stop_app
$ctl -n $node reset

echo "joining..."
$ctl -n $node join_cluster $master 

#restart the app
$ctl -n $node start_app