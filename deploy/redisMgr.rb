#! /usr/bin/env ruby

require('redis')

Account="10013"
Group=""
Group_key= "users:#{Account}:groups"
Group_follows="users:#{Account}:group:#{Group}:follows"

redis = Redis.new(:host=>'localhost')

# puts "flush all..."
# redis.flushall

puts redis.keys("*")
groups = redis.smembers(Group_key)

puts "#{groups.inspect}"