# TeamGen
# Just does a small ship crew as a proof of concept.
#
# usage:  ruby bin/TeamGen

#$LOAD_PATH << File.expand_path("../../lib/Careers", __FILE__)
#$LOAD_PATH << File.expand_path("../../lib/Tools", __FILE__)

require "tools/character"
require "tools/character_tools"
require "tools/presenter"

def list_careers(career_dir)
  careers = Array.new
  Dir.foreach(career_dir) do |file|
    fname = "#{career_dir}/#{file}"
    careers << File.basename(file, '.rb') if File.file?(fname)
  end
  careers
end


available_careers = []
load_dirs = $LOAD_PATH.uniq
load_dirs.each do |dir|
  if dir.end_with?("careers")
    available_careers = list_careers(dir)
  end
end


roles = Hash("Pilot" => "Pilot", "Gunner" => "Gunnery", "Engineer" => "Eng")

roles.each_key do |role|
  terms = rand(4) + 1
  puts "== #{role} =="
  career = "Navy"
  require File.join('careers', career.downcase)
  this_career = Module.const_get(career).new
  character = Character.new
  character.generate
  character.run_career(this_career, terms)
  options = Hash.new
  options["character"]  = character
  options["skill"]      = roles[role]
  character.increase_skill(options)
  Presenter.show(character)
end
