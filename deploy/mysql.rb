#! /usr/bin/env ruby

require 'net/ssh'

SERVER='172.16.206.16'
ACCOUNT='root'
PASSWORD='123456'

Net::SSH.start(SERVER,ACCOUNT,:password=>PASSWORD) do |ssh|
	#ssh.exect "ls /etc/init.d"
	ssh.exec "sudo /etc/init.d/mysql.server restart"
end	