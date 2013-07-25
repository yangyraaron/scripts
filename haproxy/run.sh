#!/bin/bash

bin=/usr/local/sbin/haproxy
config=~/scripts/haproxy/warren.conf #~/scripts/haproxy/rabbit_config.conf

start(){
	sudo $bin -f $config

	echo "haproxy started"
}

shutdown(){
	sudo killall $bin

	echo "haproxy stopped"
}

read -p "run or stop " run

case $run in
	run )
	start;
	;;
	stop)
	shutdown;
	;;
esac