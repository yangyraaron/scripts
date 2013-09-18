#!/bin/bash

account=root@172.16.206.16
folder=/usr/local/mysql/data
save_folder=~/16_mysql

declare -a data_files=('/msyql-host.err' )

for f in ${data_files[@]}; do
	file_path=$folder$f
	echo "downloading $file_path ..."

	scp $account:$file_path $save_folder$f
done

echo "done"
