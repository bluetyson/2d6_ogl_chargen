#!/usr/bin/env ruby

require 'sqlite3'

begin
  db = SQLite3::Database.open "../data/names.db"

  gender = 'female'

  get_first_name = db.prepare "SELECT * from humaniti_#{gender}_first ORDER BY RANDOM() LIMIT 1"
  first_name_result = get_first_name.execute

  get_last_name = db.prepare "SELECT * from humaniti_last ORDER BY RANDOM() LIMIT 1"
  last_name_result = get_last_name.execute
 
  first_name = first_name_result.first
  last_name = last_name_result.first

  puts "Hello, I'm #{first_name} #{last_name}."

rescue SQLite3::Exception => e
  puts "Exception occured:"
  puts e

ensure 
  get_last_name.close if get_last_name
  get_first_name.close if get_first_name

  db.close if db

end

