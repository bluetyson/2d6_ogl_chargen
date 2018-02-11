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
    stuff   = {
      'cash'      => 250,
      'benefits'  => ['Gun', 'Uniform']
    }
    p_data  = { 
      'coll'      => collection,
      'person'    => person,
      'modify'    => 'stuff',
      'new_data'  => stuff
    }
    update_target(p_data) 
=begin
    p_data  = Hash.new 
    p_data['coll']      = collection
    p_data['person']    = person
    p_data['modify']    = 'stuff'
    p_data['new_data']  = ['cash', 'benefits']
=end
  end 
end
 
client.close()
