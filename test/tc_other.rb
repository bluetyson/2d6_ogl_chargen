# Testing the Other class.

require "test/unit"
require "character"
require "character_tools"
require "careers/other"

class TestOther < Test::Unit::TestCase

  def setup
    @character = Character.new
    @character.generate
    @career = "Other"
    these_terms  = 2
    @character.careers[@career] = these_terms
    @half_terms = (@character.careers[@career] / 2) + 1
    this_career = Module.const_get(@career).new
    @character.run_career(this_career, these_terms)
  end

  def test_career
    assert(@character.careers.key?(@career))
  end

  def test_terms
    assert(@character.careers[@career] == 2)
  end

  def test_muster_out_cash
    assert(@character.stuff.has_key?('cash'))
    min_cash = 1000 * @half_terms
    max_cash = 100000 * @half_terms
    assert(@character.stuff["cash"] >= min_cash) 
    assert(@character.stuff['cash'] <= max_cash) 
  end 

  def test_muster_out_benefits
    assert(@character.stuff.has_key?('benefits'))
    assert(@character.stuff['benefits'].count <= @half_terms)
  end

end
