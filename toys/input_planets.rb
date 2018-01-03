#!/usr/bin/env ruby

require 'csv'
require 'mongo'

begin
  data_file = File.open('../data/planetary_information.csv', 'r')
rescue SystemCallError => e
  e.message
  exit
end

begin
  Mongo::Logger.logger.level = Logger::WARN
  client  = Mongo::Client.new(['localhost:27017'], :database => 'places')
  db      = client.database
rescue
  puts "Cannot connect to the database."
  exit
end

collection  = client[:planets]

data_file.each_line do  |line|
  line       = line.strip()
  line_array = line.split(',')
  puts line_array[1]
  puts line_array.length
  if line_array[0].length > 1
    hex           = line_array[0]
  else
    hex           = "unknown"  
  end
  if line_array[1].length > 1
    name_3e          = line_array[1].gsub!(/"/, '')
  else
    name_3e          = "unknown"  
  end
  if line_array[2].length > 1
    name_tdw      = line_array[2].gsub!(/"/, '')
  else
    name_tdw      = "unknown"  
  end
  if line_array[3].length > 1
    pronounce_tdw = line_array[3].gsub!(/"/, '')
  else
    pronounce_tdw = "unknown"  
  end
  if line_array[4].length > 1
    uwp_3e = line_array[4].gsub!(/"/, '')
  else
    uwp_3e = "unknown"  
  end
  if line_array[5].length > 1
    uwp_tdw = line_array[5].gsub!(/"/, '')
  else
    uwp_tdw = "unknown"  
  end
  if line_array[6].length > 1
    trade_3e = line_array[6].gsub!(/"/, '')
  else
    trade_3e = "unknown"  
  end
  trade_tdw = "unknown"  
  if line_array[7].length > 1
    star = line_array[7].gsub!(/"/, '')
  else
    star = "unknown"  
  end
  if line_array[8].length > 1
    info = line_array[8].gsub!(/"/, '')
  else
    info = "unknown"  
  end
  if line_array[9].length > 1
    url_3e = line_array[9].gsub!(/"/, '')
  else
    url_3e = "unknown"  
  end

  system = {
    :hex            => hex,
    :name_3e        => name_3e,
    :name_tdw       => name_tdw,
    :pronounce_tdw  => pronounce_tdw,
    :uwp_3e         => uwp_3e,
    :uwp_tdw        => uwp_tdw,
    :trade_3e       => trade_3e,
    :trade_tdw      => trade_tdw,
    :star           => star,
    :info           => info,
    :url_3e         => url_3e
  }
  collection.insert_one(system)
end
