#!/bin/bash

dir=`pwd`
echo $dir

if [ $dir = /home/wisedulab2 ]; then 
   echo "true"
 else
 	echo "false"
fi

echo "writing word..."

test_file=scripts/test/test.txt

echo -e "\nexport JAVA_HOME=usr/java/jdk1.6.0_06">>$test_file
echo -e "\nexport CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar">>$test_file