# Class for Navy characters.

require "character_tools"
require "career"

class Navy < Career 
  def initialize
    @skill_options = array_from_file('navy_base_skills.txt')
    @advanced_skill_options = array_from_file('navy_advanced_skills.txt')
    @muster_out_benefits = Hash.new
    @muster_out_benefits["cash"] = [1000, 50000]
    @muster_out_benefits["benefits"] = array_from_file('navy_muster_stuff.txt')
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
