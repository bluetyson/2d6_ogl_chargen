$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "home_planet"

planet = HomePlanet.new
puts planet.name

