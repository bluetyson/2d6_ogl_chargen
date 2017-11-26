# Class for the Nobility based on Robert Weaver's article. 
# The skill choices are used by permission from 
# http://ancientfarfuture.blogspot.com/2014/05/lords-of-imperium-revisiting-noble.html
# Thanks Robert!

require "character_tools"
require "career"

class Noble < Career 
  def initialize
    @skill_options = [ 
      "+1 Int", 
      "+1 Edu", 
      "Carousing", 
      "JoT",
      "Leader",
      "Brawling",
      "Hunting",
      "Pilot",
      "Leader",
      "GunCbt",
      "Vehicle",
      "Medical",
      "Leader",
      "Admin",
      "Carousing",
      "Liaison",
      "Bribery",
      "Gabmling"
      ]
    @advanced_skill_options = [
      "Leader",
      "Admin",
      "Liaison",
      "Bribery",
      "JoT",
      "Computer"
      ]

    @muster_out_benefits = Hash.new
    @muster_out_benefits["cash"] = [10000, 200000]
    @muster_out_benefits["benefits"] = [
      "HighPsg",
      "HighPsg",
      "Gun",
      "Blade",
      "TAS",
      "Yacht"
    ] 
  end

  def rank(character)
    terms = character.careers["Noble"]
    promotion_roll_required = 10 - terms
    promotion_level = (CharacterTools.roll_2 - promotion_roll_required) / 3
    if promotion_level > 0 
      options               = Hash.new
      options["character"]  = character
      if character.noble?
        options["stat_mod"] = "+#{promotion_level} Soc"
        options["skill"]      = @advanced_skill_options.sample
        CharacterTools.modify_stat(options) 
      else
        character.upp[:soc] = 11
        options["skill"]      = @skill_options.sample
      end
      CharacterTools.increase_skill(options) 
    end
  end

end
