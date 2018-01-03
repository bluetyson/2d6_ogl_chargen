#!/usr/bin/env ruby

require "character"
require "character_tools"
require "presenter"

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


#roles = Hash("Pilot" => "Pilot", "Gunner" => "Gunnery", "Engineer" => "Eng")
count = 310
count.times do 
  terms = rand(2) + 1
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
