require_relative './task16-weather'
require_relative './task16-06'

def runGlassHouse
  Glasshouse.new.start
end

def runMyGlassHouse
  MyGlasshouse.new.start
end

if ARGV.count == 0
  runMyGlassHouse
elsif ARGV.count != 1
  puts "usage: task16-runner.rb [my | original]"
elsif ARGV[0] == "my"
  runMyGlassHouse
elsif ARGV[0] == "original"
  runGlassHouse
else
  puts "usage: task16-runner.rb [my | original]"
end

