# Template for new Careers. To create your own Career:

# 1. Change Mycareer to your career name. One word, and Ruby 
#     classes must begin with an uppercase Alpha character.
#
# 2. Change the skill_options array to use the list of skills
#     that don"t require Edu 8+. Look at existing skill lists
#     for the format. 
#    You can duplicate entries if a career should have a higher
#     instance of some skill. 
#
# 3. Change advanced_skill_options for skills requiring an Edu 8+
#     to get in CharGen.
#
# 4. Change values in muster_out["cash"] array.
#
# 5. Change values in muster_out["benefits"] array.
#
# 6. Change the rank method if the career has ranks. 
#     Add a commission roll as needed.
#     Add the names of the ranks. 
#     Recommended, but not required, to use terms as roll modifier.
#
# 7. Add the following stanza to the case statement in Chargen.rb:
#     when "Mycareer" then
#       require "Mycareer"
#       Mycareer.new(char)
#

require "CharacterTools"
require "Career"
require "Dice"

class Mycareer < Career 
  def initialize(char)
    @skill_options = [ 
      "+1 Str",
      "+1 Dex",
      "+1 End", 
      "+1 Int", 
      "Carouse", 
      "Brawling", 
      "GunCbt", 
      "Blade", 
      "Vehicle",
      "Bribery", 
      "Pilot", 
      "ShipsBoat", 
      "Engineering", 
      "Leader"
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
    @muster_out["cash"] = [10000, 50000, 50000, 100000, 100000, 100000, 200000]
    @muster_out["benefits"] = [
      "HighPsg",
      "HighPsg",
      "Gun",
      "Blade",
      "TAS",
      "Yacht"
    ] 
    super(char) 
  end

  def rank(char)
  end
end
