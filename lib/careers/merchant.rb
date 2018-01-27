# Class for Merchant characters.

require "character_tools"
require "career"

class Merchant < Career 
  def initialize
    @skill_options = array_from_file('merchant_base_skills.txt')
    @advanced_skill_options = array_from_file('merchant_advanced_skills.txt')
    @muster_out_benefits = Hash.new
    @muster_out_benefits["cash"] = [1000, 500000]
    @muster_out_benefits["benefits"] = array_from_file('merchant_muster_stuff.txt')
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
