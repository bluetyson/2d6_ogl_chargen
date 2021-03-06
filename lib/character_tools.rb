# CharacterTools implements modules for modifying Character objects.
# These methods are outside career data sets.

  require 'dice'

module CharacterTools

  $DATA_PATH  = File.expand_path("../../data", __FILE__)
  require 'name'
  require 'errors'

  def dice
    @dice  ||= Dice.new
  end

  NOBILITY = {
    11 => { "F" => "Dame",     "M" => "Knight" },
    12 => { "F" => "Baroness", "M" => "Baron" },
    13 => { "F" => "Marquesa", "M" => "Marquis" },
    14 => { "F" => "Countess", "M" => "Count" },
    15 => { "F" => "Duchess",  "M" => "Duke" }
  }

  def roll_1
    dice.roll_1
  end

  def roll_2
    dice.roll_2
  end

  def roll_66
    dice.roll_66
  end 

  def upp_to_s(upp = @upp)
    my_str  = ""
    counter = 1
    upp.each_pair do |k, v|
      my_str << '-' if counter == 7 
      my_str << v.to_s(16).upcase
      counter += 1
    end
    return my_str
  end

  def generate_upp
    upp = Hash.new(0)
    upp[:str] = roll_2
    upp[:dex] = roll_2
    upp[:end] = roll_2
    upp[:int] = roll_2
    upp[:edu] = roll_2
    upp[:soc] = roll_2
    return upp
  end

  def upp_s_to_h(upp_s)
    upp_a       = upp_s.split('')
    upp_h       = Hash.new
    upp_h[:str] = upp_a[0].to_i(16)
    upp_h[:dex] = upp_a[1].to_i(16)
    upp_h[:end] = upp_a[2].to_i(16)
    upp_h[:int] = upp_a[3].to_i(16)
    upp_h[:edu] = upp_a[4].to_i(16)
    upp_h[:soc] = upp_a[5].to_i(16)
    return upp_h
  end

  def generate_gender
    ['M', 'F'].sample
  end

  def generate_traits
    traits = Array.new
    traits << get_random_line_from_file("positive_traits.txt")
    traits << get_random_line_from_file("negative_traits.txt")
  end 

  def generate_appearence
    app = String.new
    app << generate_hair + " hair, "
    app << generate_skin + " skin"
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
 
  def social_status( upp = @upp)
    status = case upp[:soc]
      when 0..5   then  "other"
      when 11..15 then  "noble"
      else              "citizen"
    end
    return status 
  end

  def noble?()
    return @upp[:soc] > 10 ? true : false
  end

  def title( upp = @upp, gender = @gender)
    soc = upp[:soc]
    if NOBILITY.has_key?(soc)
      return NOBILITY[soc][gender]
    end
  end 
 
  def roll_several(num = 1, dice = 2)
    rolls = Array.new
    num.times {
      case dice
        when 1
          rolls << roll_1
        when 2
          rolls << roll_2
        when 66
          rolls << roll_66
      end
    }
    return rolls
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
      stat      = stat_mod.split[1].downcase.to_sym
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
    # Still need to work on this. 
    # Block the tracebacks if possible.
    fname       = $DATA_PATH + "/" + file
    raise MissingFile.new("No #{fname} file, sorry.") unless File.readable?(fname)
    new_file    = File.open(fname, "r")
    new_array   = Array.new
    new_file.each do |line|
      line.chomp!
      if line !~ /#/ and line.length > 4
        new_array << line
      end
    end
    new_file.close()
    return new_array
  end

  def get_random_line_from_file(file)
    # Still need to work on this. 
    # Block the tracebacks if possible.
    fname       = $DATA_PATH + "/" + file
    begin 
      new_file    = File.open(fname, "r")
      new_array   = Array.new
      new_file.each do |line|
        line.chomp!
        if line !~ /#/ and line.length > 4
          new_array << line
        end
      end
      return new_array.sample
    rescue IOError
      raise MissingFile.new("No #{fname} file, sorry.")
    ensure
      new_file.close() unless new_file.nil?
    end
  end

  def generate_plot
    begin
      return get_random_line_from_file("plots.txt"), rand(1..6)
    rescue SystemCallError
      return "Some drab plot", rand(1..6)
    end
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

  def upp_mod(upp, stat)
    case upp[stat]
      when 15
        3
      when 13..14
        2
      when 10..12
        1
      when 3..5
        -1
      when 1..2
        -2
      else
        0
    end
  end

  def skill_mod(skills, skill, assume_zero=false)
    if skills.has_key?(skill)
      skill_value = skills[skill]
    elsif assume_zero
      skill_value = 0
    else
      skill_value = -3
    end
    return skill_value
  end

  def roll_mod(char, skill, stat, assume_zero = false)
    total_mod = skill_mod(char.skills, skill, assume_zero) + upp_mod(char.upp, stat)
    return total_mod
  end
  
  module_function :get_random_line_from_file
  module_function :generate_temperament
  module_function :generate_plot

end
