require "character_tools"
include CharacterTools

class Character

  attr_accessor :gender, :name, :upp, :skills, 
      :careers, :age, :rank, :stuff, :title,
      :appearence, :species, :plot, :temperament

  def initialize(char = {})
    @char = char
  end 

  def generate
    @upp          = @char.fetch('upp', CharacterTools::UPP.generate)
    @gender       = @char.fetch('gender', generate_gender)
    @species      = @char.fetch('species', generate_species)
    @opts         = {'gender' => @gender, 'species' => @species}
    @name         = @char.fetch('name', generate_name(@opts))
    @appearence   = @char.fetch('appearence', generate_appearence)
    @age          = @char.fetch('age', 18)
    @plot         = @char.fetch('plot', generate_plot)
    @temperament  = @char.fetch('temperament', generate_temperament)
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
