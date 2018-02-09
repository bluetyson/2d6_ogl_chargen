$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'mongo'
require 'character'
require 'presenter'
require 'optparse'

Mongo::Logger.logger.level = Logger::WARN
client  = Mongo::Client.new(['localhost:27017'], :database => 'people')
db      = client.database

options = {}
parser = OptionParser.new do |opts|
  opts.on('-n name', '--name', 'Select a character by name') do |n|
    options[:name] = n
  end
end
parser.parse!

name = options[:name]

collection = db[:dragons]
collection.find("name" => /#{name}/).each do |d|
  drag = Hash[d]
  dragon = Character.new(drag)
  Presenter.show(dragon)
  [ :str, :dex, :end, :int, :edu, :soc].each { |stat|
    s = stat.to_s
    puts "#{s.capitalize} mod is #{dragon.upp_mod(dragon.upp, stat)}."
  }
end
