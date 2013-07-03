#! /bin/bash
mysql_dir=/usr/local/mysql/
mysql_exe=$mysql_dir/bin/mysqld_safe
mysql_admin=$mysql_dir/bin/mysqladmin
mysql_bin=$mysql_dir/bin
mysql_data=$mysql_dir/data
mysql_message=$mysql_dir/share/english/

read -p "what operation do you want to do? 1:start 2:stop " operation

start(){
	echo "starting mysql..."
	sudo $mysql_exe --ledir=$mysql_bin --datadir=$mysql_data --lc-messages-dir=$mysql_message --user=mysql &	
}
stop(){
 	echo "stopping mysql..."
 	sudo $mysql_admin -u root -p shutdown
 	echo "mysql stopped"
 }

 case $operation in
 	[1]|start)
	start;
	;;
	[2]|stop)
	stop;
	;;
 esac

 #--ledir=/usr/local/mysql-5.6.11/bin --datadir=/usr/local/mysql-5.6.11/data --lc-messages-dir="/usr/local/mysql-5.6.11/share/english/"