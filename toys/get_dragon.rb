require 'mongo'
require 'character'
require 'presenter'
require 'optparse'

Mongo::Logger.logger.level = Logger::WARN
client  = Mongo::Client.new(['localhost:27017'], :database => 'dragons')
db      = client.database

options = {}
parser = OptionParser.new do |opts|
  opts.on('-c character', '--character', 'Select a character') do |c|
    options[:character] = c
  end
end
parser.parse!

name = options[:character]

collection = client[:dragons]
collection.find("name" => /#{name}/).each do |d|
  drag = Hash[d]
  dragon = Character.new(drag)
  dragon.careers = {"Warder" => 1}
  dragon.generate
  Presenter.show(dragon)
end

