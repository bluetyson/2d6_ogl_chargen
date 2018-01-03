require "CharacterTools"
require "Career"
require "Dice"

class Marine < Career 
  def initialize(char)
    @skill_options = [ 
      "Brawling", 
      "Gambling", 
      "+1 Str", 
      "+1 Dex", 
      "+1 End", 
      "Blade", 
      "Vehicle", 
      "VaccSuit", 
      "Blade", 
      "GunCbt", 
      "GunCbt", 
      "GunCbt", 
      "Vehicle", 
      "Mechanical", 
      "Electronic", 
      "Tactics", 
      "Blade" 
      ]
    @advanced_skill_options = [
      "Medical", 
      "Tactics", 
      "Tactics",  
      "Computer", 
      "Admin", 
      "Leader"
      ]

    @muster_out = Hash.new
    @muster_out["cash"] = [2000, 5000, 5000, 10000, 20000, 30000, 40000]
    @muster_out["benefits"] = [
      "LowPsg",
      "+2 Int",
      "+1 Edu",
      "Blade",
      "TAS",
      "HighPsg",
      "+2 Soc"
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
    officers = %w[ LT CPT FC LTC COL BG ]
    enlisted = %w[ PVT LCP CPL LSGT SGT LDSG 1SGT GSGT SMSG ]
    commission   = 9
    commission_roll  = Dice.roll_dice(6,2,1) + char['terms'] - commission
    if commission_roll >= 0
      char['character'].rank = officers[commission_roll/2]
    else
      char['character'].rank = enlisted[char['terms'] + rand(2)]
    end
  end

end
