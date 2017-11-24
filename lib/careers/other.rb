require "character_tools"
require "career"

class Other < Career
  def initialize
    @skill_options = [ 
      "+1 Str",
      "+1 Dex",
      "+1 Edu", 
      "-1 Soc", 
      "Brawling", 
      "Blade", 
      "Vehicle",
      "Gambling", 
      "Brawling", 
      "Bribery", 
      "Blade", 
      "GunCbt", 
      "Streetwise", 
      "Mechanical", 
      "Electronic", 
      "Gambling", 
      "Brawling", 
      "Forgery" 
      ]
    @advanced_skill_options = [
      "Medic",
      "Computer",
      "Forgery",
      "Electronic", 
      "Liaison",
      "Streetwise", 
      "JoT"
      ]

    @muster_out_benefits = Hash.new
    @muster_out_benefits["cash"] = [1000, 100000]
    @muster_out_benefits["benefits"] = [
      "LowPsg",
      "+1 Int",
      "+1 Edu",
      "Gun",
      "HighPsg"
    ]
  end
 
end
