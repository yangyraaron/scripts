#!/bin/bash

start=$CATALINA_HOME/bin/startup.sh
stop=$CATALINA_HOME/bin/shutdown.sh

read -p "please indicate the operation you want to do 1:start 2:stop " operation



start(){
	$start
}

stop(){
	$stop
}

case $operation in
	[1]|start)
	start;
	;;
	[2]|stop)
	stop;
	;;
esac