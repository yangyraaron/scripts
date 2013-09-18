#! /usr/bin/env ruby

require 'net/scp'
require 'net/ssh'

LOCAL_PATH = '/home/wisedulab2/wisedu_projects/Project/microblog-cache/target/microblog.war'
TOMCATE_PATH='/opt/apache-tomcat-7.0.37'
REMOTE_PATH = "#{TOMCATE_PATH}/webapps/microblog.war"
SERVER='172.16.206.16'
ACCOUNT='root'
PASSWORD='123456'
SCRIPT_START="#{TOMCATE_PATH}/bin/startup.sh"
SCRIPT_SHUTDOWN="#{TOMCATE_PATH}/bin/shutdown.sh"
WEB_APP_PATH="#{TOMCATE_PATH}/webapps/microblog"
WEB_APPS_PATH="#{TOMCATE_PATH}/webapps"


def log(stream,data)
		case
	when stream==:stderr
		$stderr.puts "-------------------------\n"
		$stderr.puts "error: #{data}"
		$stderr.puts "-------------------------"
	else
		$stdout.puts "-------------------------\n"
	 	$stdout.puts "result: #{data}"
	 	$stdout.puts "-----------------------"
	end
end

puts 'building...'

system "cd /home/wisedulab2/wisedu_projects/Project/microblog-cache \n mvn install"

puts "uploading..."

Net::SCP.upload!(SERVER,ACCOUNT,LOCAL_PATH,REMOTE_PATH,:ssh=>{:password=>PASSWORD})

Net::SSH.start(SERVER,ACCOUNT,:password=>PASSWORD) do |ssh|

	puts 'removing old app folder...'

	ssh.exec("rm -R #{WEB_APP_PATH}") do |channel,stream,data|
		log(stream,data)
	end

	puts 'restarting tomcat...'
	ssh.exec!SCRIPT_SHUTDOWN do |channel,stream,data|
		log(stream,data)
	end
	ssh.exec!SCRIPT_START do |channel,stream,data|
		log(stream,data)
	end

	ssh.exec "ls -l #{WEB_APPS_PATH}"
end

puts 'done'