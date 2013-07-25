#!/bin/bash

bin=/usr/local/rabbitmq_server-3.1.3/sbin/rabbitmq-plugins

enable(){
	$bin enable $1
}

disable(){
	$bin disable $1
}

list(){
	$bin list -v
}

read -p "specify 0:operation 1:plugin name " oper name

case $oper in
	enable|en )
	enable $name;
		;;
	disable|dis)
	disable $name;
		;;
	list|ls)
	list;
		;;
esac