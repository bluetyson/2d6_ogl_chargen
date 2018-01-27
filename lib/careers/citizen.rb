# Class for the regular citizens. Takes a character, and optional number of terms.

require "character_tools"
require "career"

class Citizen < Career
  
  def initialize
  @skill_options = array_from_file('citizen_base_skills.txt') 
  @advanced_skill_options = array_from_file('citizen_advanced_skills.txt')
  @muster_out_benefits = Hash.new
  @muster_out_benefits["cash"] = [ 1000, 9000 ]
  @muster_out_benefits["benefits"] = array_from_file('citizen_muster_stuff.txt')
    
  end
end
