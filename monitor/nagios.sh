#! /bin/bash

echo "installing prerequisites"

#sudo apt-get install build-essential apache2 php5-gd  libgd2-xpm libgd2-xpm-dev libapache2-mod-php5
#sudo apt-get install clamav*

echo "downloading the nagios and plugins it depends on"
cd /tmp
# wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.0.0.tar.gz
#  wget http://sourceforge.net/projects/nagiosplug/files/nagiosplug/1.4.16/nagios-plugins-1.4.16.tar.gz

echo "adding user and group"
# sudo useradd nagios
# sudo groupadd nagcmd
# usermod -a -G nagcmd nagios

echo "uncompressing..."
# tar zxvf nagios-4.0.0.tar.gz
# tar zxvf nagios-plugins-1.4.16.tar.gz

cd nagios

echo "configuring..."
# sudo ./configure --with-nagios-group=nagios --with-command-group=nagcmd --with-mail=/usr/bin/sendmail

# echo "making..."
# sudo make all
# sudo make install
# sudo make install-init
# sudo make install-config
# sudo make install-commandmode
# sudo make install-webconf

# sudo cp -R contrib/eventhandlers/ /usr/local/nagios/libexec/
# sudo chown -R nagios:nagios /usr/local/nagios/libexec/eventhandlers
# sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
sudo /etc/init.d/nagios start

echo "creating a default user for webaccess"
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

# echo "installing plugins"
# cd /tmp/nagios-plugins-1.4.16
# ./configure --with-nagios-user=nagios --with-nagios-group=nagios
# sudo make 
# sudo make install

# echo "setting up service"
# sudo ln -s /etc/init.d/nagios /etc/rcS.d/S99nagios


echo "done"

