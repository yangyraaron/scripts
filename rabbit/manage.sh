#!/bin/bash

ctl=/usr/local/rabbitmq_server-3.1.3/sbin/rabbitmqctl
server=/usr/local/rabbitmq_server-3.1.3/sbin/rabbitmq-server

status(){
	$ctl status
}

addVhost(){
	$ctl add_vhost $1
}

listVhosts(){
	$ctl list_vhosts
}

stop_node(){
	if [ -z $1 ]; then
		echo "please sepcify host "
		rout stopnode
	fi

	host = rabbit@$1
	echo "trying to stop the $host rabbit node "
	$ctl -n $host
	echo "node stopped"
}

stop_rabbit(){
	echo "trying to stop the $host rabbit application "
	$ctl stop_app
	echo "rabbit application stopped "

}

start_node(){
	echo "trying to start rabbit node "
	$server
	echo "rabbit node started "
}

start_rabbit(){
	echo "trying to start rabbit application "
	$ctl start_app
	echo "rabbit application started"
}

add_user(){
	if [ -z $1 ]; then
		echo "please sepcify user account "
		rout adduser
	fi

	echo "trying to add user $1 and pwd $2"
	$ctl add_user $1 $2
	echo "user added"
}

delete_user(){
	if [ -z $1 ]; then
		echo "please sepcify user account "
		rout deleteuser
	fi

	echo "are you sure to delete user $1 ? y/n "
	read yes_or_no

	case yes_or_no in
		yes|y|Y|YES)
		echo "trying to delete user $1 "
		$ctl delete_user $1
		echo "user deleted"
		;;
	esac
}

list_users(){
	$ctl list_users
}

change_password(){
	if [ -z $1 ]; then
		echo "please sepcify the user account "
		rout changepassword
	fi

	if [ -z $2 ]; then
		echo "please sepcify the new password "
	fi

	$ctl change_password $1 $2
}

set_permssion(){
	host=$1
	user=$2
	r_config=$3
	r_write=$4
	r_read=$5

	if [ -z $host ];then
		echo "the virtual host is needed"
		rout set_permssion
	fi

	if [ -z $user ];then
		echo "the user is needed"
		rout set_permssion
	fi


	$ctl set_permssions -p $host $user $r_config $r_write $r_read
}

rout(){
	isHandled=1;
	case $1 in
	startnode)
	start_node
	isHandled=0;
	;;

	status)
	status
	isHandled=0;
	;;

	start)
	start_rabbit
	isHandled=0;
	;;

	addhost)
	read -p "sepcify virtual host name " vhost
	addVhost $vhost
	isHandled=0;
	;;

	hosts)
	listVhosts
	isHandled=0;
	;;

	stop)
	stop_rabbit
	isHandled=0;
	;;

	stopnode)
	read -p "sepcify host name " host
	stop_node $host
	isHandled=0;
	;;

	adduser)
    read -p "sepcify the user account and password you want to add " user password
	add_user $user $password
	isHandled=0;
	;;

	deleteuser)
	read -p "sepcify the user account you want to delete " user
	delete_user $user
	isHandled=0;
	;;

	users)
	list_users
	isHandled=0;
	;;

	changepassword)
	read -p "sepcify the user account you want to change the password to and what the passowd value " user passowd
	change_password $user $passowd
	isHandled=0;
	;;

esac
if [ isHandled ]; then
	echo "command can not be found "
fi
#to to head looply
heading
}

heading(){
	read -p "please type your command " cmd 

	if [ $cmd = "exit" ]; then
		exit 0
	fi

	rout $cmd
}

heading



