require "CharacterTools"
require "Career"

class LEO < Career 
  def initialize(char)
    @skill_options = [ 
      "+1 Str",
      "+1 Dex",
      "+1 End", 
      "+1 Int", 
      "Athletics",
      "Blade", 
      "Brawling", 
      "Bribery", 
      "Carouse", 
      "Deception",
      "GunCbt", 
      "Intrusion",
      "Leader",
      "Persuade",
      "Recon",
      "Stealth",
      "Streetwise",
      "Vehicle"
      ]
    @advanced_skill_options = [
      "Admin",
      "Computer",
      "Electronics",
      "Interrogation",
      "Investigate",
      "Legal",
      "Liaison",
      "Science(Forensic)",
      "Tactics"
      ]

    @muster_out = Hash.new
    @muster_out["cash"] = [1000, 5000, 5000, 10000, 10000, 10000, 20000]
    @muster_out["benefits"] = [
      "LowPsg",
      "MedPsg",
      "Gun",
    ] 
    super(char) 
  end

  def first_term(char)
    career_skill_list     = ["Admin", "Carouse", "Computer", "GunCbt", "Investigate", "Streetwise", "Science(Forensic)"]
    career_skill          = career_skill_list[rand(career_skill_list.length - 1)]
    options               = Hash.new(0)
    options["character"]  = char["character"]
    options["level"]      = 1
    options["skill"]      = career_skill
    CharacterTools.increase_skill(options)
  end

  def rank(char)
    ranks = %w[Recruit Officer Patrol Sergeant Lieutenant Captain Chief]
    char["character"].rank = ranks[char["terms"]]
  end
end
