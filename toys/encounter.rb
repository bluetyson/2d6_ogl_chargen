# encounter.rb
# Uses ../data/encounter_people.txt
# Edit the file to fit your game.

$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'character_tools'
include CharacterTools

number    = CharacterTools.roll_1
reaction  = CharacterTools.roll_2
encounter = CharacterTools.get_random_line_from_file('encounter_people.txt')

print("Type: %s   Count: %d   Reaction: %d\n" %
  [ encounter, number, reaction])


