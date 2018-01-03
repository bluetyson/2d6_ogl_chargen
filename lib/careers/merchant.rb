# Class for Merchant characters.

require "character_tools"
require "career"

class Merchant < Career 
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
      "Survival",
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
      "Broker",
      "Broker",
      "Broker",
      "Broker",
      "Broker",
      "Mechanical",
      "VaccSuit",
      "Eng",
      "Steward",
      "Eng",
      "Admin",
      "JoT",
      "Electronic",
      "Admin",
      "Medical",
      "Computer",
      "Medical",
      "Medical",
      "Steward",
      "Mechanical",
      "Steward",
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
      "Admin",
      "Liaison",
      "Legal",
      "Legal",
      "Legal",
      "Leader",
      "Pilot",
      "Pilot",
      "ShipTactics",
      "Leader",
      "Computer",
      "Electronics",
      "GunCbt",
      "Admin",
      "Bribery",
      "+1 Int",
      "JoT"
      ]

    @muster_out_benefits = Hash.new
    @muster_out_benefits["cash"] = [1000, 500000]
    @muster_out_benefits["benefits"] = [
      "+1 Int",
      "+1 Edu",
      "Blade",
      "Gun",
      "HighPsg",
      "ShipPortion"
    ] 
  end

  def rank(character)
    terms = character.careers["Merchant"]
    officers = %w[ 4OFF 3OFF 2OFF 1OFF XO Capt ]
    enlisted = %w[ Merchant ]
    commission   = 10
    commission_roll  = CharacterTools.roll_1 + terms - commission
    if commission_roll >= 0
      character.rank = officers[commission_roll/2]
    else
      character.rank = enlisted[terms + rand(2)]
    end
  end
end
