include CharacterTools

class Career
  
  def first_term(char)
  end

  def rank(char)
  end

  def muster_out(options)
    character   = options["character"]
    terms       = options["terms"]
    skill_stuff = ["Blade", "Gun", "TAS", "Weapon"]
    until terms < 1 do
      terms -= 2
      cash_min        = @muster_out_benefits["cash"][0]
      cash_max        = @muster_out_benefits["cash"][-1]
      cash_diff       = cash_max - cash_min
      character.stuff["cash"] += rand(cash_diff) + cash_min
      benefit = @muster_out_benefits["benefits"].sample
      if benefit.match(/\+/)
        stat_options               = Hash.new(0)
        stat_options["character"]  = character
        stat_options["level"]      = benefit.split[0].to_i
        stat_options["stat"]       = benefit.split[1]
        CharacterTools.modify_stat(stat_options)
      elsif skill_stuff.include?(benefit) && character.stuff["benefits"].has_key?(benefit)
        options               = Hash.new(0)
        case benefit
          when "Blade"
            options["character"]  = character
            options["skill"]      = "Blade"
            options["level"]      = 1
            CharacterTools.increase_skill(options)
          when "Gun" 
            options["character"]  = character
            options["skill"]      = "GunCbt"
            options["level"]      = 1
            CharacterTools.increase_skill(options)
          when "TAS" 
            character.stuff["cash"] += @muster_out_benefits["cash"][-1]
          when "Weapon"
            options["character"]  = character
            options["skill"]      = "Weapon"
            options["level"]      = 1
            CharacterTools.increase_skill(options)
        end 
      elsif character.stuff["benefits"].has_key?(benefit)
        character.stuff["benefits"][benefit]  += 1
      else
        character.stuff["benefits"][benefit]  = 1 
      end
    end
  end

  def update_character(character, career, terms)
    this_career = career.class.to_s
    character.careers[this_career] = terms
    character.age   = character.age + (terms * 4) unless character.age > 18
    skill_points    = terms
    skill_options   = Array.new

    first_term(character)
    if character.upp[4].chr.to_i(16) >= 8
      skill_options = @skill_options + @advanced_skill_options
    else
      skill_options = @skill_options
    end
    
    rank(character)
    # Keep @skill_points late as rank can add to it.
    options               = Hash.new(0)
    options["character"]  = character
    options["terms"] = terms
    0.upto(skill_points) do
      new_skill = skill_options[rand(skill_options.count)]
      options["skill"]      = new_skill
      options["level"]      = 1
      CharacterTools.increase_skill(options)
    end 
    muster_out(options)

  end
end
