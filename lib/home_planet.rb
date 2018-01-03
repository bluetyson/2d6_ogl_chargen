#  home_planet.rb

class HomePlanet < Object
  attr_accessor :name

  def name
    planets = ['Birach', 'Saorsa', 'Atreo', 'Haearn']
    return planets.sample
  end
end

