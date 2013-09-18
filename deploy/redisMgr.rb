#! /usr/bin/env ruby

require('redis')

redis = Redis.new(:host=>'172.16.206.30')

puts "flush all..."
redis.flushall

# puts redis.keys("*")
# groups = redis.smembers("users:10013:groups")

# puts "#{groups.inspect}"