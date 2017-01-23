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
# 8. Add "Mycareer" to the "available_careers" array in Chargen.rb.
#

require "CharacterTools"
require "Career"
require "Traveller"

class Army < Career 
  def initialize(char)
    @skill_options = [ 
      "Brawling",
      "+1 Str",
      "Gambling",
      "+1 Dex",
      "+1 End",
      "+1 End",
      "GunCbt",
      "+1 Soc",
      "+1 Soc",
      "HvyWpns",
      "Mechanical",
      "Tactics",
      "HvyWpns",
      "Mechanical",
      "Tactics",
      "Leader",
      "Leader",
      "Admin",
      "Instruction",
      "Admin",
      "FAGun",
      "Vehicle",
      "Mechanical",
      "FwdObs",
      "Computer",
      "Electronics",
      "Vehicle",
      "Vehicle",
      "Vehicle",
      "HvyWpns",
      "HvyWpns",
      "Mechanical",
      "Computer",
      "GunCbt",
      "GunCbt",
      "HvyWpns",
      "Vehicle",
      "Recon",
      "VaccSuit",
      "Vehicle",
      "CbtEng",
      "Vehicle",
      "Mechanical",
      "Electronic",
      "Medic",
      "Computer"
      ]
    @advanced_skill_options = [
      "BattleDress",
      "GunCbt",
      "GunCbt",
      "HvyWpns",
      "Demo",
      "Survival",
      "Recon",
      "+1 End",
      "GunCbt",
      "Vehicle",
      "HvyWpns",
      "Leader",
      "Tactics",
      "Tactics",
      "Leader",
      "Mechanic",
      "FwdObs",
      "Computer",
      "Electronics",
      "Medical",
      "Instruction",
      "Admin",
      "Admin",
      "FAGun",
      "Medic",
      "Computer",
      "Admin",
      "Liaison",
      "Leader",
      "JoT"
      ]

    @muster_out = Hash.new
    @muster_out["cash"] = [2000, 5000, 5000, 10000, 10000, 10000, 20000, 30000]
    @muster_out["benefits"] = [
      "LowPsg",
      "+1 Int",
      "+2 Edu",
      "Gun",
      "HighPsg",
      "MidPsg",
      "+1 Soc"
    ] 
    super(char) 
  end

  def rank(char)
    officers = %w[ 2LT 1LT CPT MAJ LTC COL BG MG LG GEN ]
    enlisted = %w[ PVT LCP CPL LSGT SGT GSGT LDSGT 1SGT SGTM ]
    commission   = 5
    commission_roll  = Traveller.roll_dice(6,2,1) + char['terms'] - commission
    if commission_roll >= 0
      grade                   = [commission_roll/3 , officers.length - 1].min
      char['character'].rank = officers[grade]
    else
      grade                   = [char['terms'] + rand(2), enlisted.length - 1].min
      char['character'].rank  = enlisted[grade]
    end
  end

end
