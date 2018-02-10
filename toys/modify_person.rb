# modify_person.rb
# Adjusts data in MongoDB datastore.

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'mongo'
require 'character_tools'

Mongo::Logger.logger.level = Logger::WARN
client      = Mongo::Client.new(['localhost:27017'], :database => 'people')
collection  = client[:people]

def update_target(data)
  collection  = data['coll']
  person      = data['person']
  modify      = data['modify']
  new_data    = data['new_data']

  collection.update_one({"_id" => person['_id']}, 
    {"$set" => 
      {
      modify  => new_data
      }
    })
end

collection.find({'background': /Oregund gang/}).each do |person|
  name    = person['name']
  age     = person['age'].to_i
  morale  = ((age - 12) / 2) + 6
  unless person['morale']
    p_data              = Hash.new
    p_data['coll']      = collection
    p_data['person']    = person
    p_data['modify']    = 'morale'
    p_data['new_data']  = morale
    update_target(p_data) 
  end
end
 
client.close()
