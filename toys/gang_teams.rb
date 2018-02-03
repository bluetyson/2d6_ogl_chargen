
require 'mongo'
require 'character'
require 'presenter'

Mongo::Logger.logger.level = Logger::WARN
client  = Mongo::Client.new(['localhost:27017'], :database => 'people')
db      = client.database

counter = 0
teams   = Hash.new
teams[:leaders] = Array.new
teams[:alpha]   = Array.new
teams[:bravo]   = Array.new
teams[:charlie] = Array.new
teams[:delta]   = Array.new

collection  = db[:people]
collection.find().each { |d|
  p = Hash[d]
  person = Character.new(p)
  if person.name == "Damien Mora" or person.name == "Carter Shelton"
    teams[:leaders]   << person
  else
    case counter
    when 0
      teams[:alpha]   << person
    when 1
      teams[:bravo]   << person
    when 2 
      teams[:charlie] << person
    when 3
      teams[:delta]   << person
      counter = -1
    end
  end
  counter += 1
}

teams.each_pair { |name, team|
  if name.to_s == 'leaders'
    print("=== Squad Leaders  ===\n\n")
  else 
    print("=== Fire Team  #{name.capitalize}  ===\n\n")
  end

  team.each { |character|
    Presenter.show(character)
  }
}
