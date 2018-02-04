
$LOAD_PATH << File.expand_path("../../lib", __FILE__)
require 'character'
require 'character_tools'
require 'test/unit'
#load    'character_tools'

class TestCharacterTools < Test::Unit::TestCase

  def test_upp_to_s
    upp = {:str => 10, :dex => 7, :end =>2, :int =>14, :edu =>12, :soc => 12 }
    assert(CharacterTools.upp_to_s(upp) == "A72DCC")
  end

end
