#require 'net/scp'

require "net/sftp"
require './logger'

SERVER='172.16.206.17'
ACCOUNT='mysql-lab2'
PASSWORD='123456'
LOCAL_PATH='/usr/local/apache-tomcat-7.0.40/webapps/redis-test'
REMOTE_TOMCAT_PATH='/usr/local/apache-tomcat-7.0.42'
REMOTE_PATH="#{REMOTE_TOMCAT_PATH}/webapps/redis-test"

# Net::SCP.start(SERVER,ACCOUNT,:password=>PASSWORD) do |scp|
#   scp.upload!(LOCAL_PATH,REMOTE_PATH,:recursive=>true) do |event, uploader, *args|
#     case event
#     # args[0] : file metadata
#     when :open
#       puts "start uploading.#{args[0].local} -> #{args[0].remote} #{args[0].size} bytes}"
#     when :put then
#       # args[0] : file metadata
#       # args[1] : byte offset in remote file
#       # args[2] : data being written (as string)
#       puts "writing #{args[2].length} bytes to #{args[0].remote} starting at #{args[1]}"
#     when :close then
#       # args[0] : file metadata
#       puts "finished with #{args[0].remote}"
#     when :mkdir then
#       # args[0] : remote path name
#       puts "creating directory #{args[0]}"
#     when :finish then
#       puts "all done!"
#     end
#   end
# end
#

def sudo_exec(channel,command)
  channel.request_pty
  channel.exec(command)

  channel.on_close do
    puts "shell terminated!"
  end
  channel.on_eof do |ch|
    puts "remote end is done sending data"
  end
  channel.on_extended_data do |ch,type,data|
    puts "got stderr:#{data.inspect}"
  end
  channel.on_data do |ch,data|
    if data =~ /^\[sudo\] password for #{ACCOUNT}:/
      puts "data works"
      channel.send_data "#{PASSWORD}\n"
    else
      puts "OUTPUT NOT MATCHED: #{data}"
    end

    channel.on_data do |ch,data|
      puts "in third"
      puts data
    end
  end
  channel.on_process do |ch|
    puts "in process..."
  end

  channel.wait

end

puts "removing the redis-test folder"
Net::SSH.start(SERVER,ACCOUNT,:password=>PASSWORD) do |ssh|

  #sudo_exec(ssh,"sudo rm -r #{REMOTE_PATH}")
  #sudo_exec(ssh,"mkdir #{REMOTE_PATH}")

  ssh.exec!("rm -r #{REMOTE_PATH}") do |channel,stream,data|
    ConsoleLogger.ssh_log(stream,data)
  end
  ssh.exec!("mkdir #{REMOTE_PATH}") do |channel,stream,data|
    ConsoleLogger.ssh_log(stream,data)
  end
end

puts "uploading ..."

Net::SFTP.start(SERVER,ACCOUNT,:password=>PASSWORD) do |sftp|
  sftp.upload!(LOCAL_PATH,REMOTE_PATH)
end

puts "restarting tomcat..."

Net::SSH.start(SERVER,ACCOUNT,:password=>PASSWORD) do |ssh|
	ssh.open_channel do |channel|
		puts "shutdown ..."
		#sudo_exec(channel,"sudo #{REMOTE_TOMCAT_PATH}/bin/shutdown.sh")
		#channel.wait
		puts "startup ..."
  		sudo_exec(channel,"sudo #{REMOTE_TOMCAT_PATH}/bin/startup.sh")
	end

  # ssh.exec!("echo 123456 | sudo -S #{REMOTE_TOMCAT_PATH}/bin/shutdown.sh") do |channel,stream,data|
  #   ConsoleLogger.ssh_log(stream,data)
  # end

  # ssh.exec!("echo 123456 | sudo -S #{REMOTE_TOMCAT_PATH}/bin/startup.sh") do |channel,stream,data|
  #   ConsoleLogger.ssh_log(stream,data)
  # end
end
