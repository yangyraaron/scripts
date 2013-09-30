#!/bin/env ruby

require('redis')

#redis1=Redis.new(:host=>'127.0.0.1',:port=>'6379')
#redis2=Redis.new(:host=>'127.0.0.1',:port=>'6380')

# puts redis1.ping
# puts redis2.ping



Values=[1..10000,10001..20000,20001..30000,30001..40000,40001..50000,
        50001..60000,60001..70000,70001..80000,80001..90000,90001..100000]

Threads=[]

def test(host,port)

  Values.each do |range|
    Threads << Thread.new(range) do |t_range|
      redis_instance = Redis.new(:host=>host,:port=>port)

      t_range.each do |r|
        count = r.to_s
        key = "test:#{count}"
        value= "hello world #{count}"

        puts "host : #{host} port : #{port} seting key : #{key} value : #{value} \n"

        redis_instance.set(key,value)
      end
    end
  end
end


puts 'begin testing ...'

test '127.0.0.1','6380'
test '127.0.0.1','6379'

# wait for all threads has finished
Threads.each{|t| t.join}
