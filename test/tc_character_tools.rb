
$LOAD_PATH << File.expand_path("../../lib", __FILE__)
require 'test/unit'

class TestCharacterTools < Test::Unit::TestCase

  require 'character_tools'
  include CharacterTools

  def test_upp_to_s
    upp = {:str => 10, :dex => 7, :end =>2, :int =>14, :edu =>12, :soc => 12 }
    assert(upp_to_s(upp) == "A72ECC")
  end

  def test_upp_psion_to_s
    upp = {:str => 10, :dex => 7, :end =>2, :int =>14, 
      :edu =>12, :soc => 12, :psr => 7 }
    assert(upp_to_s(upp) == "A72ECC-7")
  end

  def test_generate_upp
    upp = generate_upp
    upp_s = upp_to_s(upp)
    assert(upp_s.match(/[2-9A-F]{6}/))
  end
end
