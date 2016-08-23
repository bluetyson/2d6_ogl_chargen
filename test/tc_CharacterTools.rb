$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "CharacterTools"
require "test/unit"
require "pp"

class TestCharacterTools < Test::Unit::TestCase

  def setup
    @character = CharacterTools.init
  end

  def test_init
    genders = ["Male", "Female"]
    assert(@character.age == 18) 
    assert(@character.upp.length == 6)
    assert(@character.upp.match(/[0-9A-F]/))
    assert(@character.name.length > 1)
    assert(genders.include?(@character.gender))
    assert(@character.hair.length >= 4)
    assert(@character.hair.match(/[a-zA-Z]/))
    assert(@character.skin.length >= 4)
    assert(@character.skin.length <= 15)
    assert(@character.skin.match(/[a-z]/))
  end

  def test_add_career
    terms = 2
    career = "Scout"
    @char = { 
      'character' => @character, 
      'career' => career, 
      'terms' => terms} 
    CharacterTools.add_career(@char)
    assert(@character.age == 18 + (terms * 4))
    assert(@character.careers.has_key?(career))
    assert(@character.careers[career] == terms) 
  end

  def test_temprament
    temprament  = CharacterTools.temprament
    assert(temprament.class == String)
    assert(temprament.length >=5)
  end

  def test_plot
    plot  = CharacterTools.plot
    assert(plot.class == String)
    assert(plot.length >=5)
  end

  def test_add_second_career
    terms = 2
    career = "Scout"
    @char = { 
      'character' => @character, 
      'career' => career, 
      'terms' => terms} 
    CharacterTools.add_career(@char)
    terms2 = 1
    career2 = "Merchant"
    @char2 = { 
      'character' => @character, 
      'career' => career2, 
      'terms' => terms2} 
    CharacterTools.add_career(@char2)
    assert(@character.age == 18 + ((terms + terms2) * 4))
    assert(@character.careers.has_key?(career))
    assert(@character.careers[career] == terms) 
    assert(@character.careers.has_key?(career2))
    assert(@character.careers[career2] == terms2) 
  end

  def test_add_college

  end

  def test_stat_modifier
    options = Hash.new(0)
    @character.upp = "777777"
    options['character'] = @character
    options['index'] = 5 
    options['minimum'] = "A" 
    options['modifier'] = 1 
    # This test should not provide a modifier.
    assert(CharacterTools.stat_modifier(options) == 0)
    # This test should provide a modifier.
    @character.upp = "77777A"
    assert(CharacterTools.stat_modifier(options) == 1)
  end 

  def test_social_status
    @character.upp = "777771"
    assert(CharacterTools.social_status(@character) == "Other")
    @character.upp = "777777"
    assert(CharacterTools.social_status(@character) == "Citizen")
    @character.upp = "77777F"
    assert(CharacterTools.social_status(@character) == "Noble")
  end

  def test_increase_skill
    options               = Hash.new(0)
    options["character"]  = @character
    assert(@character.skills.length == 0)
    options["skill"]      = "GunCbt"
    options["level"]      = 2
    CharacterTools.increase_skill(options)
    assert(@character.skills.has_key?("GunCbt"))
    assert(@character.skills["GunCbt"] == 2)
    CharacterTools.increase_skill(options)
    assert(@character.skills["GunCbt"] == 4)
    @character.upp = "777777"
    options["skill"]      = "+1 Str"
    CharacterTools.increase_skill(options)
    options["skill"]      = "+1 Dex"
    CharacterTools.increase_skill(options)
    options["skill"]      = "+1 End"
    CharacterTools.increase_skill(options)
    options["skill"]      = "+1 Int"
    CharacterTools.increase_skill(options)
    options["skill"]      = "+1 Edu"
    CharacterTools.increase_skill(options)
    options["skill"]      = "+1 Soc"
    CharacterTools.increase_skill(options)
    assert(@character.upp == "888888")

    @character.upp = "777777"
    options["skill"]      = "+10 Str"
    CharacterTools.increase_skill(options)
    options["skill"]      = "+10 Dex"
    CharacterTools.increase_skill(options)
    options["skill"]      = "+10 End"
    CharacterTools.increase_skill(options)
    options["skill"]      = "+10 Int"
    CharacterTools.increase_skill(options)
    options["skill"]      = "+10 Edu"
    CharacterTools.increase_skill(options)
    options["skill"]      = "+10 Soc"
    CharacterTools.increase_skill(options)
    assert(@character.upp == "FFFFFF")

    @character.upp = "777777"
    options["skill"]      = "-10 Str"
    CharacterTools.increase_skill(options)
    options["skill"]      = "-10 Dex"
    CharacterTools.increase_skill(options)
    options["skill"]      = "-10 End"
    CharacterTools.increase_skill(options)
    options["skill"]      = "-10 Int"
    CharacterTools.increase_skill(options)
    options["skill"]      = "-10 Edu"
    CharacterTools.increase_skill(options)
    options["skill"]      = "-10 Soc"
    CharacterTools.increase_skill(options)
    assert(@character.upp == "222222")
  end

  def test_modify_stat
    @character.upp        = "777777"
    options               = Hash.new(0)
    options["character"]  = @character
    options["stat"]       = "Int"
    options["stat_level"] = 2
    CharacterTools.modify_stat(options)
    assert(@character.upp == "777977")
  end

  def test_modify_stat_failure_empty_upp
    assert_raise(ArgumentError){
    @character.upp        = ""
    options               = Hash.new(0)
    options["character"]  = @character
    options["stat"]       = "Int"
    options["stat_level"] = 2
    CharacterTools.modify_stat(options)  
    }
  end  

=begin
  def test_modify_stat_failure_non_hex_upp
    assert_raise(TypeError){
    @character        = "" 
    options               = Hash.new(0)
    options["character"]  = @character
    options["stat"]       = "Int"
    options["stat_level"] = 2
    CharacterTools.modify_stat(options)  
    }
  end  
=end
end
