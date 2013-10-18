#!/bin/bash

account=root@172.16.206.16
folder=/opt/apache-tomcat-7.0.37/logs/
save_folder=~/16_tomcat/

declare -a data_files=('localhost_access_log.2013-10-16.txt' 'localhost.2013-10-16.log' 
	'catalina.2013-10-16.log' 'catalina.out')

for f in ${data_files[@]}; do
	file_path=$folder$f
	echo "downloading $file_path ..."

	scp $account:$file_path $save_folder$f
done

echo "done"


# account=mysql-lab2@172.16.206.17
# folder=/usr/local/apache-tomcat-7.0.42/logs/
# save_folder=~/17_tomcat/

# declare -a data_files=('localhost.2013-10-08.log' 
# 	'catalina.2013-10-08.log' 'catalina.out')

# for f in ${data_files[@]}; do
# 	file_path=$folder$f
# 	echo "downloading $file_path ..."

# 	scp $account:$file_path $save_folder$f
# done

# echo "done"
