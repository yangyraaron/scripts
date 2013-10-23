#! /bin/bash

echo "downloading and installing jdk7..."
#wget -c http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-linux-x64.tar.gz

# file=/home/wisedulab2/softwares/jdk-7u45-linux-x64.tar.gz
# echo "extracting and installing..."
# sudo tar zxvf $file  -C /usr/lib/jvm 
#cd /usr/lib/jvm  
# sudo mv jdk1.7.0_45/ java-7-sun 

# profile=~/.bashrc

java_home=/usr/lib/jvm/java-7-sun
# jre_home=$java_home/jre

# echo -e "\nexport JAVA_HOME=$java_home">>$profile
# echo -e "\nexport JRE_HOME=$java_home/jre">>$profile
# echo -e "\nexport CLASSPATH=.:$java_home/lib:$jre_home/lib">>$profile
# echo -e "\nexport PATH=$PATH:$java_home/bin">>$profile

#change java jdk

sudo update-alternatives --install /usr/bin/java java $java_home/bin/java 300
sudo update-alternatives --install /usr/bin/javac javac $java_home/bin/javac 300
sudo update-alternatives --config java