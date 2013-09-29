#!/bin/bash

account=root@172.16.206.16
folder=/opt/apache-tomcat-7.0.37/logs/
save_folder=~/16_tomcat/

declare -a data_files=('localhost_access_log.2013-09-27.txt' 'localhost.2013-09-27.log' 
	'catalina.2013-09-27.log' 'catalina.out')

for f in ${data_files[@]}; do
	file_path=$folder$f
	echo "downloading $file_path ..."

	scp $account:$file_path $save_folder$f
done

echo "done"
