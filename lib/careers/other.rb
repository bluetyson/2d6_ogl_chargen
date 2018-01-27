require "character_tools"
require "career"

class Other < Career
  def initialize
    @skill_options = array_from_file('other_base_skills.txt')
    @advanced_skill_options = array_from_file('other_advanced_skills.txt')
    @muster_out_benefits = Hash.new
    @muster_out_benefits["cash"] = [1000, 100000]
    @muster_out_benefits["benefits"] = array_from_file('other_muster_stuff.txt')
  end
 
end
