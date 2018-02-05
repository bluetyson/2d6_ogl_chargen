
$LOAD_PATH << File.expand_path("../../lib", __FILE__)
require 'test/unit'

class TestCharacterTools < Test::Unit::TestCase

  require 'character_tools'
  include CharacterTools

  def test_NOBILITY
    assert(NOBILITY[15]['F'] == 'Duchess')
  end

  def test_roll_1
    rolls = Array.new
    1000.times do 
      rolls << roll_1
    end
    assert(rolls.min == 1)
    assert(rolls.max == 6)
  end
  
  def test_roll_2
    rolls = Array.new
    1000.times do 
      rolls << roll_2
    end
    assert(rolls.min == 2)
    assert(rolls.max == 12)
  end

  def test_roll_66
    rolls = Array.new
    1000.times do
      rolls << roll_66
    end
    rolls.each { |r|
      assert(r.match(/[1-6]{2}/))
      assert(r.class == String)
    }
  end

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
 
  def test_generate_gender
    genders = ['M', 'F']
    assert(genders.include?(generate_gender))
  end 

  def test_generate_traits
    traits = Array.new
    traits = generate_traits
    assert(traits.count == 2)
    traits.each  { |t| 
      assert(t.class == String)
      assert(t.length >= 4)
    }
  end

  def test_appearence
    app = generate_appearence
    assert(app.length > 15)
    app_array = app.split()
    assert(app_array.include?('hair,'))
    assert(app_array.include?('skin'))
  end

  def test_generate_hair
    hair  = generate_hair
    assert(hair.length > 15)
    hair_array = Array.new
    hair_array = hair.split()
    assert(hair_array.length >= 4)
  end

  def test_generate_skin
    skin  = generate_skin
    assert(skin.class == String)
    assert(skin.length >= 4)
  end

  def test_generate_name
    options = { 'gender' => 'F', 'species' => 'humaniti' }
    name = generate_name(options)
    assert(name.class == String)
    assert(name.length >= 8)
    name_array = name.split()
    assert(name_array.length == 2)
  end

  def test_generate_species
    assert(generate_species == 'humaniti')
  end

  def test_social_status_low
    upp  = {:soc => 0}
    assert(social_status(upp) == 'other')
  end
    
  def test_social_status_average
    upp  = {:soc => 10}
    assert(social_status(upp) == 'citizen')
  end
    
  def test_social_status_high
    upp  = {:soc => 15}
    assert(social_status(upp) == 'noble')
  end
 
end
