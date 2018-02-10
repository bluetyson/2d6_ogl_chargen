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
      #"upp_s"  => "#{dragon['upp']}", 
      #"upp"     => new_upp,
      #"careers" => careers,
      #"dob"     => dob
      modify  => new_data
      }
    })
end

collection.find({'background': /Oregund gang/}).each do |person|
  #terms = (dragon['age'] - 18) / 4
  #terms = 1 if terms < 2
  #careers = { dragon['career'] => terms }
  #yob     = 1416 - dragon['age']
  # yob * 1000 makes the dates as place work out right. 1397123.
  #dob     = (yob * 1000) + rand(1..360)
  #new_upp = upp_s_to_h(dragon['upp'])
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
