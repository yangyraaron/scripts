#! /bin/bash

login(){
	account=$1
	echo "login with $1"
}

execute(){
 	echo "executing..."

}

scp_remote(){
	account=$1
	is_download=$2

	read -p "please type the source file " source_file
	read -p "please type the destination file " des_file

	#if  download the source file is remote server else on local
	if [[ $is_download ]]; then
		scp $account:$source_file $des_file
	else
		scp $source_file $account:$des_file
	fi
}

main(){
	read -p "specify remote account " account

	login $account

	read -p "type in the command " cmd

	if [[ $cmd = "download" ]]; then
		scp_remote $account 0
	elif [[ $cmd = "upload" ]]; then
		scp_remote $account 1
	else
		execute $cmd
	fi
}

main