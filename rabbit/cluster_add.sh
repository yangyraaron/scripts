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

# cluster a node to master
# @$1 node name
# @$2 is ram node
clustering(){

	node=$1@$HOSTNAME

	echo "stopping and resetting..."
	$ctl -n $node stop_app
	$ctl -n $node reset

	echo "joining..."
	if [[ $2 ]]; then
		echo "join cluster as ram node"
		$ctl -n $node join_cluster $master --ram
	else
		echo "join cluster as disk node"
		$ctl -n $node join_cluster $master 
	fi


	#restart the app
	$ctl -n $node start_app
}

starting 5672 rabbit
starting 5673 rabbit_1
starting 5674 rabbit_2

clustering rabbit_1
clustering rabbit_2 0

