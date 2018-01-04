#  home_planet.rb

#$DATA_PATH = File.join("../../data", __FILE__)

class StarSystem < Object
  attr_accessor :name

  def initialize
    @systems = Array.new
      system_file = File.open('../data/planetary_information.csv', 'r')
      system_file.each do |line|
        line_array = line.split(',')
        system = line_array[1].gsub!(/\"/, '')
        @systems << system
      end
  end

  def name
    return @systems.sample
  end
end

