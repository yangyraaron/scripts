#! /usr/bin/env ruby

require 'net/scp'
#require 'net/ssh'

# BACKUP_PATH='/opt/apache-tomcat-7.0.37'
# LOCAL_PATH='/home/wisedulab2/backup/16/apache-tomcat-7.0.37'
# SERVER='172.16.206.16'
# ACCOUNT='root'
# PASSWORD='123456'

# puts "backuping..."
# Net::SCP.download!(SERVER,ACCOUNT,BACKUP_PATH,LOCAL_PATH,:ssh=>{:password=>PASSWORD},:recursive=>true)
# puts "done"
system "cd /home/wisedulab2/wisedu_projects/Project/microblog-cache \n ls \n mvn install"