$LOAD_PATH << File.expand_path("../../lib/Tools", __FILE__)

require "character"
require "character_tools"
require "test/unit"
require "pp"

class TestCharacterTools < Test::Unit::TestCase

  def setup
    @character = Character.new
    @character.generate
  end

  def test_init
    genders = ["M", "F"]
    assert(@character.age == 18) 
    assert(@character.upp.length == 6)
    assert(@character.upp.match(/[0-9A-F]/))
    assert(@character.name.length > 1)
    assert(genders.include?(@character.gender))
    assert(@character.appearence.length >= 10)
    words_in_appearence = @character.appearence.split
    assert(words_in_appearence.length > 6)
    assert(@character.appearence.match(/[a-zA-Z]/))
    assert(@character.appearence.match(/hair/))
    assert(@character.appearence.match(/skin/))
  end

  def test_run_career
    terms = 2
    career = "Scout"
    @char = { 
      'character' => @character, 
      'career' => career, 
      'terms' => terms} 
    CharacterTools.run_career(@char)
    assert(@character.age == 18 + (terms * 4))
    assert(@character.careers.has_key?(career))
    assert(@character.careers[career] == terms)
  end

  def test_temperament
    temprament  = CharacterTools.generate_temperament
    assert(temprament.class == String)
    assert(temprament.length >=5)
  end
  
  def test_plot
    plot  = CharacterTools.generate_plot
    assert(plot.class == String)
    assert(plot.length >=5)
  end

  def test_add_second_career
    terms1 = 2
    career1 = "Scout"
    @char = { 
      'character' => @character, 
      'career' => career1, 
      'terms' => terms1} 
    CharacterTools.run_career(@char)
    terms2 = 1
    career2 = "Merchant"
    @char2 = { 
      'character' => @character, 
      'career' => career2, 
      'terms' => terms2} 
    CharacterTools.run_career(@char2)
    assert(@character.age == 18 + ((terms1 + terms2) * 4))
    assert(@character.careers.has_key?(career1))
    assert(@character.careers[career1] == terms1)
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

  def test_title_knight
    @character.upp = "77777B"
    @character.gender = "M"
    #@character.title = CharacterTools.get_title(@character)
    puts @character.title.class
    exit
    assert(@character.title == "Knight")
  end

  def test_title_dame
    @character.upp = "77777B"
    @character.gender = "F"
    #@character.title = CharacterTools.get_title(@character)
    assert(@character.title == "Dame")
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

  def test_modify_stat_bad_input
    assert_raise(ArgumentError){
      @character.upp        = "777777"
      options               = Hash.new(0)
      options["character"]  = @character
      options["stat"]       = "Int"
      options["stat_level"] = "a"
      CharacterTools.modify_stat(options)
    } 
  end 

  def test_modify_stat_failure_non_hex_upp
    assert_raise(ArgumentError){
    @character.upp        = "GGGGGG" 
    options               = Hash.new(0)
    options["character"]  = @character
    options["stat"]       = "Int"
    options["stat_level"] = 2
    CharacterTools.modify_stat(options)  
    }
  end  

  def test_morale_method
    morale    = CharacterTools.morale
    assert(morale >= 1)
    assert(morale <= 6) 
  end

  def test_morale_with_character
  end

  def test_not_noble?
    @character.upp = "77777A"
    assert(@character.noble? == false)
  end   

  def test_noble?
    @character.upp = "77777B"
    assert(@character.noble? == true)
  end   

  def test_get_random_line_from_file
    filename = "skin_tones.txt"
    result    = CharacterTools.get_random_line_from_file(filename)
    assert(result.length != 0)
  end

  def test_fail_get_random_line_from_file
    assert_raise(Errno::ENOENT){
      filename    = "no_such_file.rerererere"
      CharacterTools.get_random_line_from_file(filename)
    }
  end
end
