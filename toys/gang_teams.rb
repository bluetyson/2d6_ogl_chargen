
require 'mongo'
require 'character'
require 'presenter'

Mongo::Logger.logger.level = Logger::WARN
client  = Mongo::Client.new(['localhost:27017'], :database => 'people')
db      = client.database

counter = 0
leaders = Array.new
alpha   = Array.new
bravo   = Array.new
charlie = Array.new
delta   = Array.new

collection  = db[:people]
collection.find().each { |d|
  p = Hash[d]
  person = Character.new(p)
  puts counter
  if person.name == "Damien Mora" or person.name == "Carter Shelton"
    leaders   << person
  else
    case counter
    when 0
      alpha   << person
    when 1
      bravo   << person
    when 2 
      charlie << person
    when 3
      delta   << person
      counter = -1
    end
  end
  counter += 1
}

[alpha, bravo, charlie, delta].each { |team|
  puts(team.to_s)
  team.each { |character|
    Presenter.show(character)
  }
}
 
  

