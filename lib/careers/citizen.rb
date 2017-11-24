# Class for the regular citizens. Takes a character, and optional number of terms.

require "character_tools"
require "career"

class Citizen < Career
  
  def initialize
  @skill_options = [ 
    "+1 Str",
    "+1 Dex",
    "+1 Edu", 
    "+1 Int", 
    "Carouse", 
    "Brawling", 
    "Mechanical",
    "Vehicle",  
    "Streetwise",
    "Bribery",
    "Gambling",
    "Blade",
    "Steward",
    "Electronics",
    "Medical",
    "Computer",
    "Admin",
    "+1 Soc"
    ]
  @advanced_skill_options = [
    "Medic",
    "Computer",
    "Admin",
    "Liaison",
    "Leader",
    "Electronics",
    "JoT"
    ]

  @muster_out_benefits = Hash.new
  @muster_out_benefits["cash"] = [ 1000, 9000 ]
  @muster_out_benefits["benefits"] = [
    "Low Passage",
    "Blade",
    "+1 Int",
    "+2 Edu",
    "Gun",
    "Middle Passage"
    ]
  end
end
