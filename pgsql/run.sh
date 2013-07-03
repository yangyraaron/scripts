#!/bin/bash

logPath=/var/log/postgresql-9.2.4/logfile
dataPath=/var/lib/postgresql-9.2.4/data
pgsqlPath=/usr/local/pgsql/bin/pg_ctl

read -p "please indicate the operation you want to do 1:start 2:stop 3:reload " operation

start(){
	echo "starting server..."
	$pgsqlPath start -l $logPath -D $dataPath
	echo "the server started"
}

stop(){
	echo "stopping server..."
	$pgsqlPath stop -l $logPath -D $dataPath
	echo "the server stopped"
}

reload(){
	echo "reloading server..."
	$pgsqlPath reload -D $dataPath
	echo "the server reloaded"
}

case $operation in
	[1]|start)
	start;
		;;
	[2]|stop)
	stop;
		;;
	[3]|reload)
	reload;
		;;
	
esac