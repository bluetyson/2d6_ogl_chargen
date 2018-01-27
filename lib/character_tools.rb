# CharacterTools implements modules for modifying Character objects.
# These methods are outside career data sets.

module CharacterTools

  $DATA_PATH  = File.expand_path("../../data", __FILE__)
  require "name"

  NOBILITY = {
    11 => { "F" => "Dame",     "M" => "Knight" },
    12 => { "F" => "Baroness", "M" => "Baron" },
    13 => { "F" => "Marquesa", "M" => "Marquis" },
    14 => { "F" => "Countess", "M" => "Count" },
    15 => { "F" => "Duchess",  "M" => "Duke" }
  }

  def roll_1
    rand(1..6)
  end

  def self.roll_2
    rand(1..6) + rand(1..6)
  end
 
  def upp_to_s
    my_str = ""
    @upp.each_pair do |k, v|
      my_str << v.to_s(16).upcase
    end
    return my_str
  end
    
 
  UPP = Struct.new(:str, :dex, :end, :int, :edu, :soc) do
    def self.roll_2
      rand(1..6) + rand(1..6)
    end
    def self.generate_upp
      self.new(roll_2, roll_2, roll_2, roll_2, roll_2, roll_2)
    end
    def to_s
      my_str = ""
      self.each do |v|
        my_str << v.to_s(16).upcase
      end
      return my_str
    end
  end 
        
  def generate_gender
    ['M', 'F'].sample
  end

  def generate_traits
    traits = Array.new
    traits << get_random_line_from_file("positive_traits.txt")
    traits << get_random_line_from_file("negative_traits.txt")
    return traits
  end 

  def generate_appearence
    app = String.new
    app << generate_hair + " hair, "
    app << generate_skin + " skin"
    return app
  end

  def generate_hair
    begin
      t = get_random_line_from_file("hair_tone.txt")
      b = get_random_line_from_file("hair_body.txt")
      c = get_random_line_from_file("hair_colors.txt")
      l = get_random_line_from_file("hair_length.txt")
      new_hair = "#{b} #{t} #{c} #{l}"
    rescue SystemCallError
      new_hair = "Straight medium brown short" 
    end
    return new_hair
  end

  def generate_skin
    begin
      skin_tone =  get_random_line_from_file("skin_tones.txt")
    rescue SystemCallError
      skin_tone = "medium"
    end
    return skin_tone 
  end
  
  def generate_name(options)
    Name.new(options).to_s
  end
  
  def generate_species
    return "humaniti"
  end
 
  #def self.social_status(character)
  def social_status
    status = case @upp[:soc]
      when 0..5   then  "other"
      when 11..15 then  "noble"
      else              "citizen"
    end
    return status 
  end

  def title
    if NOBILITY.has_key?(@upp[:soc])
      return NOBILITY[@upp[:soc]][@gender]
    end
  end 
  
  def increase_skill(options)
    character = options["character"]
    skill     = options["skill"] 
    level     = options.has_key?("level") ? options["level"] : 1
    if skill.split.length > 1
      options["stat_mod"] = skill
      self.modify_stat(options)
    else
      if character.skills.has_key?(skill)
        character.skills[skill] += level 
      else
        character.skills[skill] = level
      end
    end
  end

  def self.modify_stat(options)
    begin
      stat_mod  = options["stat_mod"]
      character = options["character"]
      level     = stat_mod.split[0].to_i 
      stat      = stat_mod.split[1].downcase
      raise ArgumentError unless Integer(level)
      new_stat = character.upp[stat] + level
      new_stat = [new_stat, 15].min
      new_stat = [new_stat, 2].max
      character.upp[stat] = new_stat
    rescue ArgumentError
      raise
    end
  end

  def array_from_file(file)
    fname       = $DATA_PATH + "/" + file
    if File.exist?(fname)
      new_file    = File.open(fname, "r")
      new_array   = Array.new
      new_file.each do |line|
        line.chomp!
        if line !~ /#/ and line.length > 4
          new_array << line
        end
      end
    end
    return new_array
  end

  def get_random_line_from_file(file)
    begin 
      fname       = $DATA_PATH + "/" + file
      new_file    = File.open(fname, "r")
      new_array   = Array.new
      new_file.each do |line|
        line.chomp!
        if line !~ /#/ and line.length > 4
          new_array << line
        end
      end
      result = new_array.sample
    rescue SystemCallError
      raise 
    ensure
      new_file.close() unless new_file.nil?
    end
    return result
  end

  def generate_plot
    begin
      plot = get_random_line_from_file("plots.txt")
    rescue SystemCallError
      plot = "Some drab plot"
    end
    return plot, rand(1..6)
  end

  def generate_temperament
    begin
      temperament = get_random_line_from_file("temperaments.txt")
    rescue SystemCallError
      temperament = "Boring"
    end
    return temperament
  end

  def self.morale(options = "")
    morale   = roll_1
    if options.class == Hash and options["character"].careers.length > 0
      high_morales    = ["Marine", "Army", "Firster"]
      medium_morales  = ["Navy", "Scout"]
      options["character"].careers.each do |career, terms|
        morale += (1 * terms)      if high_morales.include?(career)
        morale += (0.5 * terms)    if medium_morales.include?(career)
      end 
    end
    return morale
  end

  def noble?()
    return @upp[:soc] > 10 ? true : false
  end

  module_function :get_random_line_from_file
  module_function :generate_temperament
  module_function :generate_plot

end
