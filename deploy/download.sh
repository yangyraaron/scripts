#!/bin/bash

account=root@172.16.206.16
folder=/opt
save_folder=~/16_mysql

declare -a data_files=('/db_mc.backup' )

for f in ${data_files[@]}; do
	file_path=$folder$f
	echo "downloading $file_path ..."

	scp $account:$file_path $save_folder$f
done

echo "done"
