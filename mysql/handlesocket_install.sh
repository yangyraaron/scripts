#! /bin/bash 

mysql_bindir=/usr/local/mysql/bin
mysql_source_dir=~/dev_softwares/mysql/mysql-5.6.11-source
mysql_plugin_dir=/usr/local/mysql/lib/plugin

sudo cp -R ~/dev_softwares/mysql/handlersocket /usr/local/handlersocket

cd /usr/local/handlersocket

echo "configuring..."
sudo ./autogen.sh
sudo ./configure --with-mysql-source=$mysql_source_dir --with-mysql-bindir=$mysql_bindir  --with-mysql-plugindir=$mysql_plugin_dir

echo "installing..."
sudo make 
sudo make install


