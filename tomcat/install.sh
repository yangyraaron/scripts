#! /bin/bash

url=http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-7/v7.0.40/bin/apache-tomcat-7.0.40.tar.gz

echo "downloading files"
#curl -# -o apache-tomcat-7.0.40.tar.gz $url

echo "extracting..."
tar xvzf apache-tomcat-7.0.40.tar.gz 

echo "putting it into usr/local"
mv apache-tomcat-7.0.40 /usr/local/apache-tomcat-7.0.40

profile=~/.bashrc

echo "configuring variables"
echo -e "\nexport CATALINA_HOME=/usr/local/apache-tomcat-7.0.40">>$profile
echo -e "\nexport CATALINA_BASE=/usr/local/apache-tomcat-7.0.40">>$profile

source profile