require "character_tools"
require "career"

class Firster < Career 
  def initialize  
    @skill_options = array_from_file('firster_base_skills.txt')
    @advanced_skill_options = array_from_file('firster_advanced_skills.txt')
    @muster_out_benefits = Hash.new
    @muster_out_benefits["cash"] = [10000, 200000]
    @muster_out_benefits["benefits"] = array_from_file('firster_muster_stuff.txt')
  end

  def first_term(char)
    options               = Hash.new(0)
    options["character"]  = char
    options["level"]      = 1
    options["skill"]      = "GunCbt"
    CharacterTools.increase_skill(options)
    options["skill"]      = "Recon"
    CharacterTools.increase_skill(options)
  end
end
