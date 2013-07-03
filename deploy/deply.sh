#! /bin/bash

local_file=~/wisedu_projects/Project/microblog-cache/target/microblog.war
remote_base=/opt/apache-tomcat-7.0.37
remote_dir=$remote_base/webapps/microblog.war
account=root@172.16.206.16

destination_file=$account:$remote_dir

echo $destination_file

echo "deploying..."

scp $local_file $destination_file

echo "restarting tomcat..."

ssh $account rm -R $remote_base/webapps/microblog
ssh $account $remote_base/bin/shutdown.sh
ssh $account $remote_base/bin/startup.sh

echo "complete"

