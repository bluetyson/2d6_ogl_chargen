
require "CharacterTools"
require "Career"

class Guide < Career 
  def initialize(char)
    @skill_options = [ 
      "+1 Str",
      "+1 Dex",
      "+1 End", 
      "+1 Int", 
      "Blade", 
      "Carouse", 
      "Brawling", 
      "GunCbt", 
      "GunCbt", 
      "GunCbt", 
      "Blade", 
      "Blade", 
      "Blade", 
      "Vehicle",
      "Bribery", 
      "Vehicle",
      "JoT",
      "Hunting",
      "Survival",
      "Persuade",
      "Computer",
      "Art(any)",
      "Trade(any)",
      "Recon",
      "Leader"
      ]
    @advanced_skill_options = [
      "Medic",
      "Advocate",
      "Science(any)",
      "Streetwise",
      "Liaison",
      "+1 Soc",
      "Admin",
      "Liaison",
      "Leader",
      "JoT"
      ]

    @muster_out = Hash.new
    @muster_out["cash"] = [1000, 5000, 5000, 10000, 10000, 10000, 20000]
    @muster_out["benefits"] = [
      "Gun",
      "Blade",
      "+2 Int",
      "+2 Edu",
      "+1 Soc"
    ] 
    super(char) 
  end

  def first_term(char)
    options               = Hash.new(0)
    options["character"]  = char["character"]
    options["level"]      = 1
    options["skill"]      = "GunCbt"
    CharacterTools.increase_skill(options)
    options["skill"]      = "Blade"
    CharacterTools.increase_skill(options)
  end

  def rank(char)
    char["character"].rank = nil
  end

end
