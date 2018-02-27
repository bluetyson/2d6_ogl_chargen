# tc_planet.rb

require "planet"
require "test/unit"

class TestPlanet < Test::Unit::TestCase

  def setup
    @my_planet = Planet.new("Birach", "B354623-A")
    
  end

  def test_name
    assert(@my_planet.name == "Birach")
  end

  def test_uwp
    assert(@my_planet.uwp == "B354623-A")
  end

  def test_atmo
    assert(@my_planet.atmo_label == "Thin")
  end

  def test_pop_label
    assert(@my_planet.pop_label == "Millions")
  end

  def test_base_gdp
    assert(@my_planet.base_gdp == 4400)
  end   

  def test_trade_codes
    assert(@my_planet.trade_codes.include?("Ag"))
  end 

  def test_rand_gdp_variation
    1000.times {
      assert((-50..50) === @my_planet.rand_gdp_variation)
    } 
  end

  def test_gdp_trade_code_modifiers
    assert(@my_planet.gdp_trade_code_modifier(@my_planet.trade_codes) == 0.95)
  end

  #def test_planet_new_fail_without_parameters
  #  assert_fail(my_fail_planet = Planet.new)
  #end

end
