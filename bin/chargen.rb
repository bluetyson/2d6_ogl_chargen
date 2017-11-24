# Base tool to create a quick NPC.
# ruby chargen <-c career> <-t terms>
#   career defaults based on Soc and terms to 1-5.

require "optparse"
require "tools/character_tools"
require "tools/character"
require "tools/presenter"

$LOAD_PATH << File.expand_path("../../lib/careers", __FILE__)

def list_careers(career_dir)
  careers = Array.new
  Dir.foreach(career_dir) do |file|
    fname = "#{career_dir}/#{file}"
    careers << File.basename(file, '.rb') if File.file?(fname)
  end
  careers
end

basic_character = false

available_careers = []
load_dirs = $LOAD_PATH.uniq
load_dirs.each do |dir|
  if dir.end_with?("careers")
    available_careers = list_careers(dir)
  end
end

options = Hash.new
options["careers"] = Hash.new
options["terms"]   = 0
option_parser = OptionParser.new do |opts|
  opts.on("-c CAREER", "--career CAREER", "Career, defaults based on Soc.
         Can be used more than once for multiple careers.") do |c|
    options["careers"][c] = 0 if available_careers.include?(c)
  end
  opts.on("-t TERMS", "--terms TERMS", "Terms, defaults to range of 1-5") do |t|
    options["terms"] = t.to_i
  end
  opts.on("-b", "--basic", "Just a basic Character") do
    basic_character = true
  end
  #opts.on("-s", "--sql", "Provide SQL statement output") do |s|
  #  options["sql"] = true
  #end
end
option_parser.parse!

character = Character.new
character.generate

if options["terms"] == 0
  srand && options["terms"] = rand(5) + 1
else
  options["terms"] = Integer(options["terms"])
end

unless basic_character
  options["careers"].each_key do |career|
    options["careers"][career] = options["terms"]
  end
  social_career     = CharacterTools.social_status(character)
  if options["careers"].key?(social_career) or options["careers"].count == 0
    options["careers"][social_career] = options["terms"]
  else
    options["careers"][social_career] = 1
  end
  options["careers"].each_key do |career|
    these_terms = options["careers"][career]
    require File.join('careers', career)
    this_career = Module.const_get(career.capitalize).new
    character.run_career(this_career, these_terms)
  end

end

Presenter.show(character)
#if options["sql"]
#  require "tools/presenter_sql"
#  PresenterSQL.show(character)
#end
