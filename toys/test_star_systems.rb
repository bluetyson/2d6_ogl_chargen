$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "star_systems"

planet = StarSystem.new
313.times do
  puts planet.name.capitalize
end
