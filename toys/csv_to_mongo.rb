
# csv_to_mongo.rg

require 'mongo'
require 'character'
require 'character_tools'
require 'presenter'
require 'optparse'
require '../lib/errors'

Mongo::Logger.logger.level = Logger::WARN
client  = Mongo::Client.new(['localhost:27017'], :database => 'people')
db      = client.database
collection = client[:people]

begin
  data_file = File.open('../data/converted_gang.csv', 'r')
  temp_day  = 57
  temp_year = 1416
  UPP     = Struct.new(:str, :dex, :end, :int, :edu, :soc)
rescue UnreadableFile => e
  e.message
  exit
end

def upp_str_to_struct(upp)
  new_upp = UPP.new
  new_upp[:str] = upp[0].to_i(16)
  new_upp[:dex] = upp[1].to_i(16)
  new_upp[:end] = upp[2].to_i(16)
  new_upp[:int] = upp[3].to_i(16)
  new_upp[:edu] = upp[4].to_i(16)
  new_upp[:soc] = upp[5].to_i(16)
  return new_upp
end

def csv_to_hash(line, delim = ':') 
  new_char = Hash.new(0)
  line_array  = line.split(delim)
  new_char['title']       = line_array[0]
  new_char['first_name']  = line_array[1]
  new_char['last_name']   = line_array[2]
  new_char['name']        = "#{new_char['first_name']} #{new_char['last_name']}"
  new_char['gender']      = line_array[3]
  new_char['age']         = line_array[4]
  new_char['upp']         = upp_str_to_struct(line_array[5])
  upp_s                   = line_array[5]
  new_char['appearence']  = line_array[6]
  new_char['temperament'] = line_array[7]
  plot_array = line_array[8].gsub!(/[()]/, '').split()
  plot_name = plot_array[0..-2].join(" ")
  plot_strength = plot_array[-1]
  new_char['plot']        = [plot_name, plot_strength] 
  new_char['traits']      = Array.new
  new_char['traits']      = line_array[9].split(', ')
  return new_char, upp_s
end

data_file.each { |line|
  line  = line.strip()
  next if line.length < 5 or line.start_with?('#')
  c = Hash.new
  c, upp_s = csv_to_hash(line, ':')
  character   = Character.new(c)
  character.generate
  dob_y = (temp_year - character.age.to_i).to_s
  dob_d = rand(temp_day..361).to_s.rjust(3, '0')
  dob   = dob_y + dob_d 
  char = {
    :name       => character.name,
    :first_name => character.name.split()[0],
    :last_name  => character.name.split()[1],
    :gender     => character.gender,
    :age        => character.age, 
    :dob        => dob,
    :origin_planet => 'Birach',
    :group      => 'Dragons',
    :background => 'Oregund gang',
    :upp_s      => upp_s,
    :appearence => character.appearence,
    :plot       => character.plot,
    :temperament => character.temperament,
    :traits     => character.traits,
    :upp        => {
      :str      => character.upp[:str],
      :dex      => character.upp[:dex],
      :end      => character.upp[:end],
      :int      => character.upp[:int],
      :edu      => character.upp[:edu],
      :soc      => character.upp[:soc]
    }

  }
  collection.insert_one(char)
  #puts char
}

client.close if client
