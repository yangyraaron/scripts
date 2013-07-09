#!/bin/bash

ctl=/usr/local/rabbitmq_server-3.1.3/sbin/rabbitmqctl
server=/usr/local/rabbitmq_server-3.1.3/sbin/rabbitmq-server

status(){
	$ctl status
}

list_Vhosts(){
	$ctl list_vhosts
}

add_Vhost(){
	read -p "sepcify virtual host name " host

	if [ -z $host ];then
		echo "the virtual host is need"
		return 1
	fi

	$ctl add_vhost $host
	return 0
}

stop_node(){
	read -p "sepcify virtual host " host

	if [ -z $host ]; then
		read -p "are you want to stop local node " yes_or_no

		case $yes_or_no in
			yes|YES|y|Y )
			$ctl stop
			return 0
				;;
		esac

		echo "the virtual host can not be empty"
		return 1
	fi

	server = rabbit@$host
	echo "trying to stop the $host rabbit node "
	$ctl -n $server -p stop
	echo "node stopped"

	return 0
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
    read -p "sepcify the user account and password you want to add " user password

	if [ -z $user ]; then
		echo "user account can not be empty "
		return 1
	fi

	echo "trying to add user $1 and pwd $2"
	$ctl add_user $user $password
	echo "user added"

	return 0
}

delete_user(){
	read -p "sepcify the user account you want to delete " user

	if [ -z $user ]; then
		echo "user account can not be emtpy"
		return 1
	fi

	echo "are you sure to delete user $user ? y/n "
	read yes_or_no

	case $yes_or_no in
		yes|y|YES|Y)
		echo "trying to delete user $1 "
		$ctl delete_user $user
		echo "user deleted"
		;;
	esac

	return 0
}

list_users(){
	$ctl list_users
}

change_password(){
	read -p "sepcify the user account you want to change the password to and what the passowd value " user passowd

	if [ -z $user ]; then
		echo "user account can not be empty "
		return 1
	fi

	if [ -z $passowd ]; then
		echo "please sepcify the new password "
		return 1
	fi

	$ctl change_password $user $password

	return 0
}

set_permssion(){
	read -p "the parameters needed 1:vhost 2:user 3:config  4:write 5:read " host user r_config r_write r_read

	if [ -z $host ];then
		echo "the virtual host is needed"
		return 1
	fi

	if [ -z $user ];then
		echo "the user is needed"
		return 1
	fi


	$ctl set_permssions -p $host $user $r_config $r_write $r_read

	return 0
}

permissions(){
	read -p "sepcify 1:type {-v:host -u:user} 2:host/user " t n

	if [ -z $t ];then
		echo "what type of permissions you want to look, host or user"
		return 1
	fi

	case $t in
		-v)
		
		if [ -z $n ];then
			echo "the virtual host is needed"
			return 1
		fi

		$ctl list_permissions -p $n
		;;
		-u)
		if [ -z $n ];then
			echo "the user is needed"
			return 1
		fi
		$ctl list_user_permissions $n
		;;
	esac

	return 0
}

clear_permission(){
	read -p "sepcify 1:host 2:user" host user

	if [ -z $host ];then
		echo "the virtual host is needed"
		return 1
	fi

	if [ -z $user ];then
			echo "the user is needed"
			return 1
	fi

	$ctl clear_permissions -p $host $user

	return 0
}

declare -A fun_table fun_table=(["status"]=status 
		["addhost"]=add_Vhost 
		["hosts"]=list_Vhosts 
		["stopnode"]=stop_node 
		["stop"]=stop_rabbit 
		["startnode"]=start_node 
		["start"]=start_rabbit 
		["adduser"]=add_user 
		["deleteuser"]=delete_user  
		["users"]=list_users 
		["changepassword"]=change_password 
		["setpermission"]=set_permssion 
		["permissions"]=permissions 
		["clearpermission"]=clear_permission)

recusive_exe(){
	cmd=$1
	shift 1

	method=${fun_table[$cmd]}

	if [ -z $method ];then
		echo "command not found "
		heading
	fi

	eval "$method $@"

	if [ ! $? ];then
		recusive_exe $cmd
	else
		heading
	fi
}

heading(){
	read -p "please type your command " cmd 

	if [ $cmd = "exit" ]; then
		exit 0
	fi

	recusive_exe $cmd
}

heading



