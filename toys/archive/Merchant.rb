require "CharacterTools"
require "Career"

class Merchant < Career 
  def initialize(char)
    @skill_options = [ 
      "Carouse", 
      "Brawling", 
      "Brawling", 
      "Vehicle",
      "Vehicle",
      "Gambling",
      "Gambling",
      "Trader",
      "Trader",
      "Blade", 
      "VaccSuit",
      "ZeroG",
      "Commo",
      "GunCbt", 
      "Liaison",
      "Liaison",
      "Admin",
      "Admin",
      "Admin",
      "Computer",
      "Bribery",
      "Streetwise",
      "Navigation",
      "Navigation",
      "Pilot",
      "Pilot",
      "Leader",
      "Leader",
      "Mechanical",
      "Electronic",
      "Engineering",
      "Admin",
      "Admin",
      "Admin",
      "Admin",
      "Engineering",
      "Gravitics",
      "Steward",
      "Medical",
      "Liaison",
      "Liaison",
      "Gunnery",
      "Steward",
      "Liaison",
      "Steward",
      "Medical",
      "Medical",
      "Medical",
      "Medical",
      "Computer",
      "Computer",
      "Trader",
      "Trader",
      "Bribery",
      "Legal",
      "Legal",
      "Liaison",
      "Liaison",
      "Streetwise",
      "Broker",
      "Broker",
      "GunCbt",
      "GunCbt",
      "Streetwise",
      "Streetwise",
      "Forgery",
      "Bribery",
      "Legal",
      "Steward",
      "Trader",
      "Broker",
      "Admin",
      "Gunnery",
      "Leader",
      "Engineering",
      "Navigation",
      "Steward",
      "Legal",
      "Steward",
      "Broker", 
      "VaccSuit",
      "VaccSuit",
      "Brawling",
      "Brawling",
      "+1 Dex",
      "Broker",
      "JoT",
      "+1 Edu",
      "+1 Str",
      "+1 End", 
      "+1 Int", 
      "Vehicle",
      "Bribery", 
      "Pilot", 
      "ShipsBoat", 
      "Engineering", 
      "Leader"
      ]
    @advanced_skill_options = [
      "Medic",
      "Bribery", 
      "Pilot", 
      "Pilot", 
      "Pilot", 
      "Pilot", 
      "ShipsBoat", 
      "Engineering", 
      "Pilot", 
      "Pilot", 
      "Computer",
      "Admin",
      "Pilot", 
      "Pilot", 
      "Liaison",
      "Pilot", 
      "Pilot", 
      "Leader",
      "JoT"
      ]

    @muster_out = Hash.new
    @muster_out["cash"] = [1000, 5000, 10000, 20000, 20000, 40000, 50000, 100000]
    @muster_out["benefits"] = [
      "+2 Int",
      "+2 Edu",
      "+1 End",
      "Gun",
      "TAS",
      "Blade",
      "LowPsg",
      "MidPsg",
      "FreeTrader"
    ] 
    super(char) 
  end

  def rank(char)
    ranks     = %w[ APP 4OF 3OF 2OF 1OF CPT SCP COM LCM ]
    terms     = char["terms"]
    max_rank  = ranks.length - 1
    grade     = [terms, max_rank].min
    char["character"].rank = ranks[grade]
  end
end