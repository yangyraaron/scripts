#!/bin/bash

ctl=/usr/local/rabbitmq_server-3.1.3/sbin/rabbitmqctl
server=/usr/local/rabbitmq_server-3.1.3/sbin/rabbitmq-server
master=rabbit@$HOSTNAME

# start a rabbitmy in cluster mode
# @$1 port
# @$2 node name
starting(){
	echo "starting $2@$HOSTNAME"
	RABBITMQ_NODE_PORT=$1 RABBITMQ_NODENAME=$2 $server -detached
}


starting 5675 rabbit_a
starting 5676 rabbit_b


