$LOAD_PATH << File.expand_path("../lib", __FILE__)

class Character
  DEFAULT_AGE = 18
  STAT_NAMES = %w(Str Dex End Int Edu Soc)

  attr_accessor :career, :gender, :name, :skills, :age, :upp, :officer
  attr_writer :terms

  def initialize()
    @career = ''
    @gender = set_gender
    @name = ''
    @officer = false
    @stats = {}
    @skills = Hash.new
    @upp = set_upp()
  end

  def set_name(gender='male')
    require 'sqlite3'
    begin
      db = SQLite3::Database.open "data/names.db"
      get_first_name = db.prepare "SELECT * from humaniti_#{gender}_first ORDER BY RANDOM() LIMIT 1"
      first_name_result = get_first_name.execute

      get_last_name = db.prepare "SELECT * from humaniti_last ORDER BY RANDOM() LIMIT 1"
      last_name_result = get_last_name.execute

      @name = "#{first_name_result.first} #{last_name_result.first}"
    rescue SQLite3::Exception => e
      abort(e)
    ensure
      get_first_name.close if get_first_name
      get_last_name.close if get_last_name
      db.close if db
    end
  end

  def increase_skill(skill, level=1)
    if @skills.has_key?(skill)
    then
      old_level = @skills[skill]
    else
      old_level = 0
    end
    @skills[skill] = old_level + level  
  end
 
  def set_gender
    gender_options = ['male', 'female']
    @gender ||= gender_options[rand(gender_options.length)]
    return @gender 
  end

  def age
    @age ||= (terms * 4) + DEFAULT_AGE + rand(3)
  end

  def terms
    @terms ||= 0
  end

  def set_upp
    @upp = ''
    6.times do
      stat = rand(6) + rand(6) + 2
      stat = stat.to_s(16).upcase
      @upp = @upp + stat
    end
    return @upp
  end
 
  def officer(target_roll=13)
    @officer ||=  roll2 >= target_roll
  end

end

