#!/bin/env ruby
require 'net/ssh'

Sever='172.16.206.17'
Account='mysql-lab2'
Password='123456'

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

Net::SSH.start(Sever,Account,:password=>Password) do |ssh|
	puts "start testing..."

	ssh.exec!('ab -n 1000000 -c 1000 -r  http://127.0.0.1:8080/redis-test/redis1.jsp') do |channel,stream,data|
		log(stream,data)
	end
end
