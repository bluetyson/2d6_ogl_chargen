# CharacterTools implements modules for modifying Character objects.
# These methods are outside career data sets.

module CharacterTools

  $DATA_PATH  = File.expand_path("../../../data", __FILE__)
  require "dice"
  require "name"

  NOBILITY = {
    "B" => { "F" => "Dame",     "M" => "Knight" },
    "C" => { "F" => "Baroness", "M" => "Baron" },
    "D" => { "F" => "Marquesa", "M" => "Marquis" },
    "E" => { "F" => "Countess", "M" => "Count" },
    "F" => { "F" => "Duchess",  "M" => "Duke" },
  }

  def generate_upp
    new_upp = String.new
    6.times do
      stat = Dice.roll_dice(6,2,1)
      stat = stat.to_s(16).upcase
      new_upp  = new_upp + stat
    end
    return new_upp
  end

  def generate_gender
    ['M', 'F'].sample
  end
 
  def generate_appearence
    app = String.new
    skin = generate_skin
    hair = generate_hair
    app << hair + " hair "
    app << skin + " skin"
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
 
  STAT_NAMES = %w{Str Dex End Int Edu Soc}
  def self.init
    character          = Character.new
    character.upp      = self.upp
    character.gender   = self.gender.capitalize
    character.species = "humaniti"
    options           = { "gender" => character.gender, "species" => character.species }
    character.name     = Name.new(options).to_s
    character.age      = 18
    character.hair     = self.hair
    character.skin     = self.skin
    return character
  end

  def self.social_status(character)
    soc = character.upp[5,1].to_i(16)
    status = case soc     
      when 0..5   then  "other"
      when 11..15 then  "noble"
      else              "citizen"
    end
    return status 
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
      stat      = stat_mod.split[1]
      raise ArgumentError unless Integer(level)
      stat_index = STAT_NAMES.index(stat)
      raise ArgumentError unless character.upp =~ /[0-9A-F]{6}/
      new_stat = character.upp[stat_index,1].to_i(16) + level
      new_stat = [new_stat, 15].min
      new_stat = [new_stat, 2].max
      new_stat = new_stat.to_s(16).upcase
      character.upp[stat_index] = new_stat
    rescue TypeError
      raise
    rescue ArgumentError
      raise
    end
  end

  def self.add_career(char)
    terms         = char["terms"]
    career        = char["career"]
    character     = char["character"]
    character.age += terms * 4
    character.careers[career] += terms
  end

  def self.hash_character(character)
    c_hash = Hash.new
    c_hash["name"]    = character.name
    c_hash["upp"]     = character.upp
    c_hash["age"]     = character.age
    c_hash["careers"] = character.careers
    c_hash["skills"]  = character.skills
    return c_hash
  end

  # Save the Character data.
  # Still not sure on this one. It works for the moment.
  def self.save_character(character, file, format=json)
    if File.exists?(file)
      characters = Hash.new
      characters_in = File.read(file)
      characters = JSON.parse(characters_in) 
      character_key = "#{character.upp}-#{character.name}"
      character_key.gsub!(/[ ,']/, "")
      characters[character_key] = self.hash_character(character)
      c_file = File.open(file, "w")
      c_file.write(JSON.pretty_generate(characters))
      c_file.close
    end
  end

  # Prints the character file in Pretty JSON.
  def self.show_character_file(file, format=json)
    if File.exists?(file)
      characters = Hash.new
      characters_in = File.read(file)
      characters = JSON.parse(characters_in)
      puts JSON.pretty_generate(characters) 
    end
  end

  def self.show_one_character(character, mode = "txt")
    Presenter.show(character, mode)
  end
 
  # Prints the character in some specific format. Or "txt"
  # if unspecified. 
  def self.show_characters(file, format=json, mode="txt")
    if File.exists?(file)
      characters = Hash.new
      characters_in = File.read(file)
      characters = JSON.parse(characters_in)
      characters.each do |key, array|
        character = Character.new
        character.name    = characters[key]["name"]
        character.upp     = characters[key]["upp"]
        character.gender  = characters[key]["gender"]
        character.age     = characters[key]["age"]
        character.careers = characters[key]["careers"]
        character.skills  = characters[key]["skills"]
        Presenter.show(character, mode)
      end
    end
  end

  def title()
    soc = @upp[5,1]
    if NOBILITY.has_key?(soc)
      return NOBILITY[soc][@gender]
    end
  end 

  def self.stat_modifier(options)
    stat_mod  = 0 
    upp       = options["character"].upp
    index     = options["index"]
    minimum   = options["minimum"].to_i(16)
    modifier  = options["modifier"]
    stat      = upp[index,1].to_i(16)
    stat_mod  = modifier if stat >= minimum
    return    stat_mod
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
      result = new_array[rand(new_array.length - 1)]
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
    return plot
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
    morale   = Dice.roll_dice(1,6,1)
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
    soc = @upp[5,1].to_i(16)
    return soc > 10 ? true : false
  end

  module_function :get_random_line_from_file
  module_function :generate_temperament
  module_function :generate_plot

end
