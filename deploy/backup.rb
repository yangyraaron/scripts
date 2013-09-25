#! /usr/bin/env ruby

require 'net/scp'
#require 'net/ssh'

BACKUP_PATH='/opt/microblog'
LOCAL_PATH='/home/wisedulab2/backup'
SERVER='172.16.206.16'
ACCOUNT='root'
PASSWORD='123456'

puts "backuping..."
Net::SCP.download!(SERVER,ACCOUNT,BACKUP_PATH,LOCAL_PATH,:ssh=>{:password=>PASSWORD},:recursive=>true)
puts "done"