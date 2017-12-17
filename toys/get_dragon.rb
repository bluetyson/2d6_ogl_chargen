require 'mongo'
require 'character'
require 'presenter'

Mongo::Logger.logger.level = Logger::WARN
client  = Mongo::Client.new(['localhost:27017'], :database => 'dragons')
db      = client.database

collection = client[:dragons]
collection.find("name" => "Tala Domici").each do |d|
  drag = Hash[d]
  dragon = Character.new(drag)
  dragon.generate
  dragon.upp = { :str => 9, :dex => 9, :end => 7, 
    :int => 11, :edu => 5, :soc => 11}
  dragon.careers = {"Warder" => 1}
  puts dragon.name
  Presenter.show(dragon)
end

