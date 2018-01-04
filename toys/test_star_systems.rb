$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "star_systems"

313.times do
  planet = StarSystem.new
  puts planet.name.capitalize
end
