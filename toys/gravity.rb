# Trying to figure out the math of gravity.
class Planet
  G   = 6.674e-11
  # https://en.wikipedia.org/wiki/Gravitational_constant
  PI  = 3.14

  attr_accessor :gravity

  def initialize(radius, density)
    @radius   = radius
    @density  = density
    @volume   = volume
    @mass     = mass
  end

  def get_square(num)
    num * num
  end

  def get_cube(num)
    num * num * num
  end

  def volume
    (4 / 3.0) * PI * get_cube(@radius)
  end

  def mass
    @volume * @density
  end

  def gravity
    G * @mass / get_square(@radius)
  end
end

Birach  = Planet.new(2.4e6, 14e3)
Earth   = Planet.new(6.371e6, 5.514e3)

puts "Birach's gravity is #{Birach.gravity}."
puts "Earth's gravity is #{Earth.gravity}." 
