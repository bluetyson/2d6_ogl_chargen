# planet_info.rb

$LOAD_PATH << File.expand_path('../../lib/', __FILE__)

require 'planet'

my_planet = Planet.new("Birach", "B354623-9")
pop = 3000000
mp_string = "#{my_planet.name} #{my_planet.uwp} Pop: #{pop}"
puts mp_string
mp_string.length.times {
  print("%s" % "=")
}
puts

base_gdp = my_planet.gdp(pop) / 1000000000
puts "  Base GDP: BCR #{base_gdp}"

gtcm = my_planet.gdp_trade_code_modifier(my_planet.trade_codes)
puts "  GDP Trade Code Modifier: #{gtcm}"

gdp_percent_modifier = 1 + (my_planet.rand_gdp_variation() / 100.0)
puts "  GDP % Modifier: #{gdp_percent_modifier}"

gdp_modified = base_gdp * gtcm
gdp_ty        = gdp_modified * gdp_percent_modifier
puts "  GDP This Year:  #{gdp_ty}"
