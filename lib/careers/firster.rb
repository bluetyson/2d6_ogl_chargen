require "character_tools"
require "career"

class Firster < Career 
  def initialize  
    @skill_options = [ 
      "+1 Str",
      "+1 Dex",
      "+1 End", 
      "+1 Int", 
      "Carouse", 
      "Brawling", 
      "GunCbt", 
      "Blade", 
      "Recon", 
      "Survival", 
      "Vehicle",
      "Bribery", 
      "Leader"
      ]
    @advanced_skill_options = [
      "Medic",
      "Engineering", 
      "Gunnery", 
      "Computer",
      "Admin",
      "Liaison",
      "Leader",
      "JoT"
      ]

    @muster_out_benefits = Hash.new
    @muster_out_benefits["cash"] = [10000, 200000]
    @muster_out_benefits["benefits"] = [
      "Gun",
      "Blade",
      "Vehicle"
    ] 
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
