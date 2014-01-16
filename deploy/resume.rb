#! /usr/bin/env ruby

require 'net/scp'
require 'net/ssh'
require "net/sftp"

LOCAL_PATH='/home/wisedulab2/projects'
REMOTE_PATH = "/root/resume/bin"
FILENAME = "resumeanalysis"
SERVER='172.16.206.16'
ACCOUNT='root'
PASSWORD='123456'

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


path = "#{LOCAL_PATH}/#{FILENAME}"

system " tar -cvf #{FILENAME}.tar -C #{LOCAL_PATH} #{FILENAME}"
uploading_file = "#{FILENAME}.tar"
remote_fle = "#{REMOTE_PATH}/#{FILENAME}.tar"

if not File.exists?(uploading_file)
  puts 'the compressed file has not been found'
else
  Net::SSH.start(SERVER,ACCOUNT,:password=>PASSWORD) do |ssh|
    puts "delete old files on server"
    ssh.exec! "rm  #{remote_fle} \n rm -r #{REMOTE_PATH}/#{FILENAME}" do |channel,stream,data|
      log(stream,data)
    end

    puts "uploading ..."

    Net::SFTP.start(SERVER,ACCOUNT,:password=>PASSWORD) do |sftp|
      sftp.upload!(uploading_file,remote_fle)
    end

    puts "extract #{FILENAME}.tar ... on server"
    ssh.exec! "tar -xvf #{remote_fle}" do |channel,stream,data|
      log(stream,data)
    end

    puts "extracting is done"
  end

  puts "done"

end
