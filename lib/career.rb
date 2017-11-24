include CharacterTools

class Career
  
  def first_term(character)
  end

  def rank(character)
  end

  def add_cash(character)
    cash_min  = @muster_out_benefits["cash"][0]
    cash_max  = @muster_out_benefits["cash"][-1]
    cash_diff = cash_max - cash_min
    character.stuff['cash'] += rand(cash_diff) + cash_min
  end

  def add_benefit(character)
    skill_stuff = ["Blade", "Gun", "TAS", "Weapon"]
    benefit = @muster_out_benefits["benefits"].sample
    options = {'character' => character, 'level' => 1}

    if benefit.match(/\+/)
      options['stat_mod'] = benefit
      CharacterTools.modify_stat(options)
    elsif skill_stuff.include?(benefit) && character.stuff["benefits"].has_key?(benefit)
      case benefit
        when "TAS" 
          character.stuff["cash"] += @muster_out_benefits["cash"][-1]
        else 
          options["skill"]      = benefit
          CharacterTools.increase_skill(options)
      end 
    elsif character.stuff["benefits"].has_key?(benefit)
      character.stuff["benefits"][benefit]  += 1
    else
      character.stuff["benefits"][benefit]  = 1 
    end
  end

  def muster_out(options)
    character   = options["character"]
    terms       = options["terms"]
    ((terms / 2) + 1).times do
      add_cash(character)
      add_benefit(character)
    end
  end

  def build_skill_options(character)
    if character.upp[4].chr.to_i(16) >= 8
      skill_options = @skill_options + @advanced_skill_options
    else
      skill_options = @skill_options
    end
  end

  def update_character(character, career, terms)
    this_career = career.class.to_s
    character.careers[this_career] = terms
    character.age   = character.age + (terms * 4) unless character.age > 18
    skill_points    = terms
    skill_options   = build_skill_options(character)

    first_term(character)
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
