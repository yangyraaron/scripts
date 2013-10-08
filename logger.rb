#! /usr/bin/env ruby

module ConsoleLogger
  def self.ssh_log(stream,data)
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

end
