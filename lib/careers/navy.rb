# Class for Navy characters.

require "character_tools"
require "career"

class Navy < Career 
  def initialize
    @skill_options = [ 
      "Brawling",
      "+1 Str",
      "Carouse", 
      "Gambling",
      "+1 End", 
      "+1 Dex",
      "+1 End", 
      "+1 Edu", 
      "Carouse", 
      "VaccSuit",
      "Gambling",
      "+1 Dex",
      "Blade", 
      "Brawling", 
      "GunCbt", 
      "Blade", 
      "Mechanical",
      "ShipsBoat", 
      "VaccSuit",
      "ZeroG",
      "Commo",
      "Admin",
      "JoT",
      "Carouse", 
      "Vehicle",
      "FwdObs",
      "Survival",
      "VaccSuit",
      "BattleDress", 
      "VaccSuit",
      "GunCbt", 
      "Blade", 
      "Mechanical",
      "Leader",
      "Medic",
      "ZeroG",
      "+1 Edu", 
      "Instruction",
      "Admin",
      "Vehicle", 
      "+1 End", 
      "GunCbt",
      "ShipsBoat",
      "Bribery", 
      "+1 Dex",
      "+1 Soc",
      "ShipsBoat", 
      "Vehicle", 
      "Navigation", 
      "Engineering", 
      "Mechanical",
      "Electronics",
      "GunCbt",
      "Navigation",
      "Computer",
      "Liaison",
      "ZeroG",
      "VaccSuit",
      "Admin",
      "GunCbt",
      "Commo",
      "ShipsBoat",
      "Navigation",
      "Pilot",
      "FwdObs",
      "GunCbt",
      "Commo",
      "Computer",
      "Gunnery",
      "Mechanical",
      "Electronic",
      "Eng",
      "Mechanical",
      "VaccSuit",
      "Eng",
      "Eng",
      "Eng",
      "Admin",
      "JoT",
      "Electronic",
      "Admin",
      "Medical",
      "Computer",
      "Medical",
      "Medical",
      "Mechanical",
      "Mechanical",
      "Electronic",
      "Electronic",
      "Computer",
      "Computer",
      "Gravitics",
      "JoT",
      "Leader"
      ]
    @advanced_skill_options = [
      "Medic",
      "Computer",
      "Admin",
      "Liaison",
      "Leader",
      "Pilot",
      "ShipTactics",
      "Leader",
      "ShipTactics",
      "Computer",
      "Electronics",
      "GunCbt",
      "Admin",
      "Bribery",
      "ShipTactics",
      "FleetTactics",
      "+1 Int",
      "ShipTactics",
      "FleetTactics",
      "JoT"
      ]

    @muster_out_benefits = Hash.new
    @muster_out_benefits["cash"] = [1000, 50000]
    @muster_out_benefits["benefits"] = [
      "LowPsg",
      "+1 Int",
      "+1 Edu",
      "Blade",
      "TAS",
      "HighPsg",
      "+2 Soc"
    ] 
  end

  def rank(character)
    terms = character.careers["Navy"]
     officers = %w[ EN SLT LT LTCMDR CMDR CPT COMM FADM SADM GADM ]
    enlisted = %w[ SR SA AS PO3 PO2 PO1 CPO SCPO MCPO ]
    commission   = 10
    commission_roll  = CharacterTools.roll_1 + terms - commission
    if commission_roll >= 0
      character.rank = officers[commission_roll/2]
    else
      character.rank = enlisted[terms + rand(2)]
    end
  end
end
