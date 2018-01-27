require 'mongo'
require 'character'
require 'presenter'
require 'optparse'

#Mongo::Logger.logger.level = Logger::WARN
client  = Mongo::Client.new(['localhost:27017'], :database => 'people')
db      = client.database
puts(db.collection_names)
exit

options = {}
parser = OptionParser.new do |opts|
  opts.on('-n name', '--name', 'Select a character by name') do |n|
    options[:name] = n
  end
end
parser.parse!

name = options[:name]

collection = client[:dragons]
char = collection.find_one()
puts(char)
#collection = db[:dragons]
=begin
collection.find("name" => /#{name}/).each do |d|
  drag = Hash[d]
  dragon = Character.new(drag)
  Presenter.show(dragon)
end
=end
