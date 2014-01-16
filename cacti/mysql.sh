#！/bin/bash

wget http://mysql-cacti-templates.googlecode.com/files/better-cacti-templates-1.1.8.tar.gz
tar zxvf better-cacti-templates-1.1.8.tar.gz
cd better-cacti-templates-1.1.8
cp scripts/ss_get_mysql_stats.php /usr/share/cacti/site/scripts

sudo vi /usr/share/cacti/site/scripts/ss_get_mysql_stats.php
$mysql_user = ''
$mysql_password=''
$mysql_port=3306

#test
#php -q ./ss_get_mysql_stats.php --host 172.16.206.16 --items cv,cx,cy,cz --user cacti --pass cacti --port 3306
