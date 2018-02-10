# modify_person.rb
# Adjusts data in MongoDB datastore.

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'mongo'
require 'character_tools'

Mongo::Logger.logger.level = Logger::WARN
client      = Mongo::Client.new(['localhost:27017'], :database => 'people')
collection  = client[:people]

def upp_s_to_h(upp)
  upp_a = upp.split('')
  upp_h = Hash.new
  upp_h[:str] = upp_a[0].to_i(16)
  upp_h[:dex] = upp_a[1].to_i(16)
  upp_h[:end] = upp_a[2].to_i(16)
  upp_h[:int] = upp_a[3].to_i(16)
  upp_h[:edu] = upp_a[4].to_i(16)
  upp_h[:soc] = upp_a[5].to_i(16)
  return upp_h
end

=begin 
def update_target(data)
  person    = data['person']
  modify    = data['modify']
  new_data  = data['new_data']

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
=end

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
    puts("#{name}, morale #{morale}") 
  end
end
 
client.close()
