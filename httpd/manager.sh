#!/bin/bash

ctl=/usr/local/apache2/bin/apachectl

start(){
	$ctl -k start
}

stop(){
	$ctl -k stop
}

read -p "1:start or 2:stop " oper

 case $oper in
 	[1]|start)
	start;
	;;
	[2]|stop)
	stop;
	;;
 esac