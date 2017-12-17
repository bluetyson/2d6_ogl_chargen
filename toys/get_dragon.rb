require 'mongo'
require 'character'
require 'presenter'

Mongo::Logger.logger.level = Logger::WARN
client  = Mongo::Client.new(['localhost:27017'], :database => 'dragons')
db      = client.database

name = "Tala Domici"
collection = client[:dragons]
collection.find("name" => /#{name}/).each do |d|
  drag = Hash[d]
  dragon = Character.new(drag)
  dragon.careers = {"Warder" => 1}
  dragon.generate
  Presenter.show(dragon)
end

