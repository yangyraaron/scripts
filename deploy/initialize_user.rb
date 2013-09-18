#! /usr/bin/env ruby

require 'mysql2'

MYSQL_SERVER='172.16.206.16'
MYSQL_ACCOUNT='root'
MYSQL_PASSWORD='123456'
MYSQL_DATABASE='microblog'
MYSQL_ENCODING='utf8'

puts "connecting..."

begin
	client = Mysql2::Client.new(:host=>MYSQL_SERVER,
                            :username=>MYSQL_ACCOUNT,
                            :password=>MYSQL_PASSWORD,
                            :database=>MYSQL_DATABASE,
                            :encoding=>MYSQL_ENCODING)

	users = client.query("select user_id from user")

	users.each do |row|
		user_id = row['user_id']
		puts "updating #{user_id}..."

		following_count = client.query("select count(1) follow_count from user_following where user_id='#{user_id}'")
								.first['follow_count']
		fans_count = client.query("select count(1) fans_count from user_follower where user_id='#{user_id}'")
							.first['fans_count']
		blog_count = client.query("select count(1) blog_count from message where creator_id='#{user_id}'")
							.first['blog_count']

		next if(following_count==0 && fans_count==0 && blog_count==0) 
		#puts "#{following_count}:#{fans_count}:#{blog_count}"
		client.query("update user set msg_count=#{blog_count},fans_count=#{fans_count},following_count=#{following_count} where user_id=#{user_id}")

	end

	puts 'done'


rescue Exception => e
	puts "error: #{e.inspect}"
end




