require "character"
require "test/unit"

class TestCharacter < Test::Unit::TestCase

  def setup
    @base_character = Character.new
    @character      = Character.new
    @character.generate
  end

  def test_no_upp
    assert(@base_character.upp == nil)
  end 

  def test_has_upp
    assert(@character.upp.to_s.length > 3)
  end

  def test_set_get_upp
    upp   = '789ABC'
    @base_character.upp = UPP.new(7,8,9,10,11,12)
    assert(@base_character.upp.to_s == upp)
  end

  def test_has_no_gender
    assert(@base_character.gender == nil)
  end

  def test_has_gender
    genders = ["M", "F"]
    assert(genders.include?(@character.gender))
  end

  def test_set_get_gender
    gender = 'F'
    @base_character.gender = gender
    assert(@base_character.gender == gender)
  end 

  def test_has_no_appearence
    assert(@base_character.appearence == nil)
  end

  def test_appearence_is_string
    assert(@character.appearence.class == String)
  end
  
  def test_appearence_is_longer_than_ten_characters
    assert(@character.appearence.length > 10)
  end

  def test_set_get_appearence
    appearence = "Tall, dark haired, and two out of three ain't bad."
    @base_character.appearence = appearence
    assert(@base_character.appearence == appearence)
  end

  def test_has_no_name
    assert(@base_character.name == nil)
  end

  def test_has_name
    assert(@character.name.length > 5)
  end

  def test_set_get_name
    name = 'Handsome Stranger'
    @base_character.name = name
    assert(@base_character.name == name)
  end

  def test_has_age
    assert(@character.age >= 11)
  end
    
  def test_has_no_age
    assert(@base_character.age == nil)
  end

  def test_set_get_age
    age = 18
    @base_character.age = age
    assert(@base_character.age == age)
  end
     
  def test_has_no_temperament
    assert(@base_character.temperament == nil)
  end

  def test_has_temperament
    assert(@character.temperament.length > 5)
  end

  def test_set_get_temperament
    temperament = "Moody, colorful"
    @base_character.temperament = temperament
    assert(@base_character.temperament == temperament)
  end

  def test_has_no_species
    assert(@base_character.species == nil)
  end

  def test_has_species
    assert(@character.species.class == String)
    assert(@character.species != nil)
  end
  
  def test_accepts_species
    species = "Thean"
    @base_character.species = species
    assert(@base_character.species == species)
  end

  def test_has_no_plot
    assert(@base_character.plot == nil)
  end

  def test_has_plot
    assert(@character.plot.class == String)
    assert(@character.plot.length >= 5)
  end

  def test_set_get_plot
    plot = "Murder most fowl, you turkey!"
    @base_character.plot = plot
    assert(@base_character.plot == plot)
  end 

  def test_has_no_traits
    assert(@base_character.traits == nil)
  end

  def test_has_traits
    assert(@character.traits.length >= 2)
  end

  def test_has_no_skills
    assert(@base_character.skills == nil)
  end

  def test_has_skills
    assert(@character.skills.class == Hash)
  end

  def test_set_get_skills
    skills = {'Carousing' => 1, 'GunCbt' => 1}
    @base_character.skills = skills
    assert(@base_character.skills.class == Hash)
    assert(@base_character.skills == skills)
  end

  def test_has_no_careers
    assert(@base_character.careers == nil)
  end

  def test_has_careers
    assert(@character.careers.class == Hash)
  end
  
  def test_set_get_careers
    careers = {'Noble' => 4, 'Marine' => 2}
    @base_character.careers = careers
    assert(@base_character.careers.class == Hash)
    assert(@base_character.careers == careers)
  end

  def test_has_no_stuff
    assert(@base_character.stuff == nil)
  end

  def test_has_stuff
    assert(@character.stuff.class == Hash)
    assert(@character.stuff['benefits'].class == Hash)
    assert(@character.stuff['cash'].class == Integer)
    assert(@character.stuff.length == 2)
  end
 
  def test_set_get_stuff
    stuff = { 'benefits' => Hash.new, 'cash' => 0}
    @base_character.stuff = stuff
    assert(@base_character.stuff == stuff)
  end 

end
