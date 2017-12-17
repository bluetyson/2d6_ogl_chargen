require 'mongo'

Mongo::Logger.logger.level = Logger::WARN
client  = Mongo::Client.new(['localhost:27017'], :database => 'dragons')
db      = client.database

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

collection = client[:dragons]
collection.find.each do |dragon|
  terms = (dragon['age'] - 18) / 4
  terms = 1 if terms < 2
  careers = { dragon['career'] => terms }
  yob     = 1416 - dragon['age']
  dob     = (yob * 1000) + rand(1..360)
  #new_upp = upp_s_to_h(dragon['upp'])
  collection.update_one({"_id" => dragon['_id']}, 
    {"$set" => 
      {
      #"upp_s"  => "#{dragon['upp']}", 
      #"upp"     => new_upp,
      "careers" => careers,
      "dob"     => dob
      }
    })

end
