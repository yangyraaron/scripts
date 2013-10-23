#! /bin/bash

url=http://apache.fayea.com/apache-mirror/tomcat/tomcat-7/v7.0.42/bin/apache-tomcat-7.0.42.tar.gz

# echo "downloading files"
# curl -# -o apache-tomcat-7.0.42.tar.gz $url

# echo "extracting..."
# tar xvzf apache-tomcat-7.0.42.tar.gz 

echo "putting it into usr/local"
sudo mv apache-tomcat-7.0.42 /usr/local/apache-tomcat-7.0.42

profile=~/.bashrc

echo "configuring variables"
echo -e "\nexport CATALINA_HOME=/usr/local/apache-tomcat-7.0.42">>$profile
echo -e "\nexport CATALINA_BASE=/usr/local/apache-tomcat-7.0.42">>$profile

source $profile