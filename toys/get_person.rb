
$LOAD_PATH << File.expand_path('../../lib/', __FILE__)

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

collection = db[:people]
collection.find("name" => /#{name}/).each do |d|
  p = Hash[d]
  person = Character.new(p)
  Presenter.show(person)
end
