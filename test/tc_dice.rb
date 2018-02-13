$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'dice'
require 'test/unit'

class TestDice < Test::Unit::TestCase

  def setup
    @dice = Dice.new
  end

  def test_roll_1
    rolls = Array.new
    1000.times do
      rolls << @dice.roll_1
    end
    assert(rolls.min == 1)
    assert(rolls.max == 6)
  end

  def test_roll_2
    rolls = Array.new
    1000.times do
      rolls << @dice.roll_2
    end
    assert(rolls.min == 2)
    assert(rolls.max == 12)
  end

  def test_roll_66
    roll_options = [ 
      11, 12, 13, 14, 15, 16,
      21, 22, 23, 24, 25, 26,
      31, 32, 33, 34, 35, 36, 
      41, 42, 43, 44, 45, 46,
      51, 52, 53, 54, 55, 56,
      61, 62, 63, 64, 65, 66 ]
    1000.times { 
      assert(roll_options.include?(@dice.roll_66))
    }
  end

end
