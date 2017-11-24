# Provides First and Last name based on gender and optionally species.
class Name

  PROJECT_PATH = File.expand_path(File.dirname(__FILE__))
  DATA_PATH = File.join(PROJECT_PATH, "../../data")
  
  attr_reader :name

  def initialize(options)
    @gender       ||= options["gender"]
    @species      = get_species(options)
    @name         = new_name()
  end

  def get_species(options)
    available_species = ["humaniti"]
    if options.key?("species") and available_species.include?(options["species"])
      species = options["species"]
    else
      species = available_species.sample
    end
    return species
  end

  # Pulls a first name from the database, based on gender. 
  # Gender required but defaults to male.
  # Requires sqlite3 functionality and the database file.
  def first_name()
    if @gender == "F"
      gender = "female"
    else
      gender = "male"
    end 
    begin 
      require "sqlite3"
      db = SQLite3::Database.open "#{DATA_PATH}/names.db"
      first_name_query = db.prepare "SELECT * from humaniti_#{gender}_first ORDER BY RANDOM() LIMIT 1"
      first_name_result = first_name_query.execute
      first_name = first_name_result.first
    rescue
      namefile    = "data/#{@species}_#{gender}_firstnames"
      name = name_from_file(namefile)
      return name
    ensure
      first_name_query.close if first_name_query
      db.close if db
    end
    return first_name[0].to_s
  end

  def name_from_file(file)
    if File.exist?(file)
      name_file   = File.open(file, "r") 
      name_array  = Array.new
      name_file.each do |line|
        name_array << line.chomp
      end
      name        = name_array[rand(name_array.length - 1)]
    else
      name = "Fred"
    end
  end

  # Pulls a last name from the database. In the future based on culture. 
  # Requires sqlite3 functionality and the database file.
  def last_name()
    begin 
      require "sqlite3"
      db = SQLite3::Database.open "#{DATA_PATH}/names.db"
      last_name_query = db.prepare "SELECT * from humaniti_last ORDER BY RANDOM() LIMIT 1"
      last_name_result = last_name_query.execute
      last_name = last_name_result.first
    rescue
      namefile    = "data/#{@species}_lastnames"
      name = name_from_file(namefile)
      return name
    ensure
      last_name_query.close if last_name_query
      db.close if db
    end
    return last_name[0].to_s
  end

  # Needs gender, produces first and last name as a single string.
  def new_name()
    f_name    = first_name()
    l_name    = last_name()
    return    "#{f_name} #{l_name}"
  end

  def to_s
    return @name
  end
end
