#!/bin/bash

ctl=/usr/local/rabbitmq_server-3.1.3/sbin/rabbitmqctl
server=/usr/local/rabbitmq_server-3.1.3/sbin/rabbitmq-server

status(){
	read -p "specify node " node
	if [[ -z $node ]]; then
		node=rabbit
	fi

	$ctl -n $node@$HOSTNAME status
}

list_Vhosts(){
	read -p "specify node " node
	if [[ -z $node ]]; then
		node=rabbit
	fi

	$ctl -n $node@$HOSTNAME list_vhosts
}

add_Vhost(){
	read -p "sepcify node name and virtual host name " node host

	if [ -z $host ];then
		echo "the virtual host is need"
		return 1
	fi

	if [[ -z $node ]]; then
		node=rabbit
	fi

	$ctl -n $node@$HOSTNAME add_vhost $host

	return 0
}

stop_node(){
	read -p "sepcify node " host

	if [ -z $host ]; then
		read -p "are you want to stop local node y/n? " yes_or_no

		case $yes_or_no in
			yes|YES|y|Y )
			$ctl stop
			return 0
				;;
		esac

		echo "the host can not be empty"
		return 1
	fi

	server=$host@$HOSTNAME
	echo "trying to stop the $host rabbit node "
	$ctl -n $server stop
	echo "node stopped"

	return 0
}

stop_rabbit(){
	read -p "which node do you want to stop " node

	if [[ -z $node ]]; then
		echo "trying to stop the rabbit node "
		$ctl stop_app
		echo "rabbit application stopped "
	else
		echo "trying to stop the $node rabbit node "
		$ctl -n $node@$HOSTNAME  stop_app
		echo "rabbit application stopped "
	fi

}

start_node(){
	echo "trying to start rabbit node "
	$server
	echo "rabbit node started "
}

start_rabbit(){
	read -p "which node do you want to start " node

	if [[ -z $node ]]; then
		echo "trying to start rabbit application "
		$ctl start_app
		echo "rabbit application started"
	else
		echo "trying to start the $node rabbit node "
		$ctl -n $node@$HOSTNAME  start_app
		echo "rabbit application started "
	fi

}

add_user(){
    read -p "sepcify node and  the user account and password you want to add " node user password

	if [ -z $user ]; then
		echo "user account can not be empty "
		return 1
	fi

	if [[ -z $node ]]; then
		echo "trying to add user $1 and pwd $2 to node rabbit"
		$ctl add_user $user $password
		echo "user added"
	else
		echo "trying to add user $1 and pwd $2 to node $host "
		$ctl -n $node@$HOSTNAME add_user $user $password
		echo "user added"
	fi


	return 0
}

delete_user(){
	read -p "sepcify the node and the user account you want to delete " node user

	if [ -z $user ]; then
		echo "user account can not be emtpy"
		return 1
	fi

	echo "are you sure to delete user $user ? y/n "
	read yes_or_no

	case $yes_or_no in
		yes|y|YES|Y)
		echo "trying to delete user $1 "
		if [[ -z $node ]]; then
			$ctl delete_user $user
		else
			$ctl -n $node@$HOSTNAME delete_user $user
		fi
		
		echo "user deleted "
		;;
	esac

	return 0
}

list_users(){
	read -p "specify node " node

	if [[ -z $node ]]; then
		$ctl list_users
	else
		$ctl -n $node@$HOSTNAME list_users
	fi

}

change_password(){

	read -p "sepcify node and the user account " node user 
	read -p "type the password " pass

	if [ -z $user ]; then
		echo "user account can not be empty "
		return 1
	fi

	if [ -z $pass ]; then
		echo "please sepcify the new password "
		return 1
	fi

	if [[ -z $node ]]; then
		$ctl change_password $user $pass
	else
		$ctl -n $node@$HOSTNAME change_password $user $pass
	fi
	

	return 0
}

set_permssion(){
	read -p "the parameters needed 1:vhost 2:user 3:config  4:write 5:read " host user r_config r_write r_read

	if [ -z $host ];then
		echo "the virtual host is needed "
		return 1
	fi

	if [ -z $user ];then
		echo "the user is needed "
		return 1
	fi
	# a_config=''
	# a_write=''
	# a_read=''
	if [ "$r_config" = \"\" ];then
		#echo "config empty"
		r_config=''
	fi

	if [ "$r_write" = \"\" ];then
		#echo "write empty"
		r_write=''
	fi

	if [ "$r_read" = \"\" ];then
		#echo "read empty"
		r_read=''
	fi

	read -p "specify the node " node

	if [[ -z $node ]]; then
		$ctl set_permissions -p $host $user "$r_config" "$r_write" "$r_read"
	else
		$ctl -n $node@$HOSTNAME set_permissions -p $host $user "$r_config" "$r_write" "$r_read"
	fi


	return 0
}

permissions(){
	read -p "sepcify 1:type {-v:host -u:user} 2:host/user " t n

	if [ -z $t ];then
		echo "what type of permissions you want to look, host or user "
		return 1
	fi

	read -p "specify the node " node

	case $t in
		-v)
		
		if [ -z $n ];then
			echo "the virtual host is needed"
			return 1
		fi

		if [[ -z $node ]]; then
			$ctl list_permissions -p $n
		else
			$ctl -n $node@$HOSTNAME list_permissions -p $n
		fi

		;;
		-u)
		if [ -z $n ];then
			echo "the user is needed"
			return 1
		fi

		if [[ -z $node ]]; then
			$ctl list_user_permissions $n
		else
			$ctl -n $node@$HOSTNAME list_user_permissions $n
		fi
		;;
	esac

	return 0
}

clear_permission(){
	read -p "sepcify 1:host 2:user 3:node " host user node

	if [ -z $host ];then
		echo "the virtual host is needed "
		return 1
	fi

	if [ -z $user ];then
			echo "the user is needed "
			return 1
	fi

	if [[ -z $node ]]; then
		$ctl clear_permissions -p $host $user
	else
		$ctl -n $node@$HOSTNAME clear_permissions -p $host $user
	fi

	return 0
}

queues(){
	read -p "sepcify node  host " node  host 
	if [[ -z $node ]]; then
		node=rabbit
	fi

	if [ -z $host ];then
		$ctl -n $node@$HOSTNAME list_queues name messages consumers memory
	else
		echo "display queues of default virtual host "
		$ctl -n $node@$HOSTNAME list_queues -p $host name messages consumers memory
	fi
}

exchanges(){
	read -p "sepcify node host " node host 

	if [[ -z $node ]]; then
		node=rabbit
	fi

	if [ -z $host ];then
		$ctl -n $node@$HOSTNAME list_exchanges name 'type' durable auto_delete
	else
		$ctl -n $node@$HOSTNAME list_exchanges -p $host name 'type' durable auto_delete
	fi

}

bindings(){
	read -p "sepcify node host " host 
	if [[ -z $node ]]; then
		node=rabbit
	fi

	if [[ -z $host ]]; then
	$ctl -n $node@$HOSTNAME list_bindings -p $host
	else
	$ctl -n $node@$HOSTNAME list_bindings 
	fi

}

clusters(){
	read -p "specify node " node
	if [[ -z $node ]]; then
		node=rabbit
	fi

	$ctl -n $node@$HOSTNAME  cluster_status
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
		["clearpermission"]=clear_permission 
		["queues"]=queues 
		['exchanges']=exchanges 
		['bindings']=bindings 
		['clusters']=clusters)

recusive_exe(){
	cmd=$1
	shift 1

	method=${fun_table[$cmd]}

	if [ -z $method ];then
		echo "command not found "
		heading
	fi

	eval "$method $@"

	#check the last exit code $? if 1 then execute
	if [ ! $? ];then
		recusive_exe $cmd
	# else
	# 	heading
	fi
}

heading(){

	while [[ 0 ]]; do
		read -p "please type your command " cmd 

	if [ $cmd = "exit" ]; then
		exit 0
	fi

	recusive_exe $cmd
	
	done
	
}

heading



