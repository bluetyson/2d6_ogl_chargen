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
  unless person['stuff2']
    credits = rand(1..25)
    gun     = ['Rifle', 'SMG', 'SMG', 'LAG', 'Shotgun', 'AutoRifle','Shotgun', 'Lacar', 'AssaultRifle'].sample
    stuff   = {
      'cash'      => credits,
      'benefits'  => {gun =>1}
    }
    p_data  = { 
      'coll'      => collection,
      'person'    => person,
      'modify'    => 'stuff',
      'new_data'  => stuff
    }
    update_target(p_data) 
  end 
end
 
client.close()
