#! /bin/bash

echo "downloading and installing jdk7..."
wget -c http://download.oracle.com/otn-pub/java/jdk/7/jdk-7-linux-i586.tar.gz  

echo "extracting and installing..."
sudo tar zxvf ./jdk-7-linux-i586.tar.gz  -C /usr/lib/jvm 
cd /usr/lib/jvm  
sudo mv jdk1.7.0/ java-7-sun 

profile=~/.bashrc

echo -e "\nexport JAVA_HOME=/usr/lib/jvm/java-7-sun">>$profile
echo -e "\nexport JRE_HOME=${JAVA_HOME}/jre">>$profile
echo -e "\nexport CLASSPATH=.:$(JAVA_HOME)/lib:$(JRE_HOME)/lib">>$profile
echo -e "\nexport PATH=$PATH:$(JAVA_HOME)/bin">>$profile