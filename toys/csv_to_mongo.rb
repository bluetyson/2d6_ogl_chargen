
# csv_to_mongo.rg
$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'mongo'
require 'character'
require 'character_tools'
require 'presenter'
require 'optparse'
require 'errors'

Mongo::Logger.logger.level = Logger::WARN
client  = Mongo::Client.new(['localhost:27017'], :database => 'people')
db      = client.database
collection = client[:people2]

begin
  data_file = File.open('toys/data/ben_freed_slaves.csv', 'r')
  temp_day  = 77
  temp_year = 1416
rescue UnreadableFile => e
  e.message
  exit
end

def upp_str_to_hash(upp)
  new_upp = Hash.new
  new_upp[:str] = upp[0].to_i(16)
  new_upp[:dex] = upp[1].to_i(16)
  new_upp[:end] = upp[2].to_i(16)
  new_upp[:int] = upp[3].to_i(16)
  new_upp[:edu] = upp[4].to_i(16)
  new_upp[:soc] = upp[5].to_i(16)
  return new_upp
end

def comma_to_colon(line)
  in_quote  = false
  new_line  = ''
  line.each_char { |c|
    if c == '"'
      c = ''
      if not in_quote
        in_quote = true
      else
        in_quote = false
      end
    end
    if not in_quote
      c = ':' if c == ';'
    end
    new_line += c
  }
  return new_line
end

def line_to_hash(line, sep = '-')
  new_hash    = Hash.new
  line        = line.strip()
  line_array  = line.split(',')
  line_array.each { |thing|
    thing_array   = thing.split(sep)
    key           = thing_array[0]
    value         = thing_array[1]
    value         = value.to_i if value !~ /\D/ 
    new_hash[key] = value
  }
  return new_hash
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
  new_char['upp']         = upp_str_to_hash(line_array[5])
  upp_s                   = line_array[5]
  new_char['appearence']  = line_array[6]
  new_char['temperament'] = line_array[7]
  plot_array = line_array[8].gsub!(/[()]/, '').split()
  plot_name = plot_array[0..-2].join(" ")
  plot_strength = plot_array[-1]
  new_char['plot']        = [plot_name, plot_strength] 
  new_char['traits']      = Array.new
  new_char['traits']      = line_array[9].split(', ')
  puts line_array[11]
  new_char['skills']      = Hash.new
  new_char['skills']      = line_to_hash(line_array[11], '-')
  new_char['stuff']       = Hash.new
  new_char['stuff']['cash']     = line_array[11].to_i
  new_char['stuff']['benefits'] = Hash.new
  new_char['goods']       = line_array[12]
  new_char['origin']      = line_array[14]
  return new_char, upp_s
end

data_file.each { |line|
  line  = line.strip()
  line  = comma_to_colon(line)
  puts line
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
    :origin     => character.origin,
    :group      => 'Freed',
    :background => 'Slave',
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
