require "character_tools"

class Character
  include CharacterTools

  attr_accessor :gender, :name, :upp, :skills, 
      :careers, :age, :rank, :stuff, :morale,
      :appearence, :species, :plot, :temperament, :traits,
      :origin

  def initialize(char = {})
    @char = char
    setup
  end

  def setup
    @upp          = @char['upp']
    @gender       = @char['gender']
    @species      = @char['species']
    @name         = @char['name']
    @appearence   = @char['appearence']
    @age          = @char['age']
    @plot         = @char['plot']
    @temperament  = @char['temperament']
    @traits       = @char['traits']
    @skills       = @char['skills']
    @careers      = @char['careers']
    @stuff        = @char['stuff']
    @morale       = @char['morale']
    @origin       = @char['origin']
  end 

  def generate
    @upp          = @char.fetch('upp', generate_upp)
    @gender       = @char.fetch('gender', generate_gender)
    @species      = @char.fetch('species', generate_species)
    @opts         = {'gender' => @gender, 'species' => @species}
    @name         = @char.fetch('name', generate_name(@opts))
    @appearence   = @char.fetch('appearence', generate_appearence)
    @age          = @char.fetch('age', 18)
    @plot         = @char.fetch('plot', generate_plot)
    @temperament  = @char.fetch('temperament', generate_temperament)
    @traits       = @char.fetch('traits', generate_traits)
    @skills       = @char.fetch('skills', Hash.new(0))
    @careers      = @char.fetch('careers', Hash.new(0))
    @stuff        = @char.fetch('stuff', init_stuff)
  end

  def init_stuff
    @char['stuff'] = {'cash' => 0, 'benefits' => Hash.new(0)}
  end

  def run_career(career, terms)
    career.update_character(self, career, terms)
  end
end
