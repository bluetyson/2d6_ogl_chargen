#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

if ARGV and Integer(ARGV[0]) > 1
  rolls = Integer(ARGV[0])
else
  rolls = 1
end

rolls.times do 
  puts rand(1..6) + rand(1..6)
end
