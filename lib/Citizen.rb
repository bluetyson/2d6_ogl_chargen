# Class for the regular citizens. Takes a character, and optional number of terms.

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "CharacterTools"
require "Traveller"
require "Career"

class Citizen < Career
  
  def initialize(char)
  @skill_options = [ "+1 Str",
    "+1 Dex",
    "+1 Edu", 
    "+1 Int", 
    "Carouse", 
    "Brawling", 
    "GunCbt", 
    "Blade", 
    "Hunting", 
    "+1 Dex",
    "Bribery", 
    "Drive(any)", 
    "Pilot", 
    "ShipsBoat", 
    "Drive(any)", 
    "Navigation", 
    "Engineering", 
    "Leader",
    "Athletics"
    ]
  @advanced_skill_options = [
    "Medic",
    "Computer",
    "Admin",
    "Liaison",
    "Leader",
    "JoT"
    ]

  @muster_out = Hash.new
  @muster_out["cash"] = [ 1000, 3000, 5000, 7000, 9000 ]
  @muster_out["benefits"] = [
    "Low Passage",
    "Blade",
    "+1 Int",
    "+2 Edu",
    "Gun",
    "Middle Passage"
    ]
  super(char)
  end

  # Set rank to nil so it and the space aren't printed.
  def rank(char)
    char["character"].rank = nil    
  end
end
