#!/bin/bash

read -p "please choose the operatoion you want to do, run or shutdown? 1:start 2: shutdown " operation

start(){
	/usr/local/memcached-1.4.15/bin/memcached  –vv >>/tmp/memcached.log 2>&1 &
}

shutdown(){
	killall /usr/local/memcached-1.4.15/bin/memcached
}

case $operation in
	[1]|start)
	start;
	;;
	[2]|shutdown)
	shutdown;
	;;
esac

