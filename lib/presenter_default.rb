module PresenterDefault
  require 'character_tools' 
  def PresenterDefault.show(character)
    line_counter  = 0
    lines = Array.new
    lines[line_counter] =  ""
    lines[line_counter] += "#{character.title} " if character.noble?
    lines[line_counter] += "#{character.rank} "  if character.rank
    lines[line_counter] += "#{character.name} "  if character.name
    lines[line_counter] += "#{character.gender} "  if character.gender
    lines[line_counter] += "Age: #{character.age} "   if character.age
    lines[line_counter] += "#{character.upp_to_s} " if character.upp
    if character.careers
      character.careers.each_pair do |career, terms|
        lines[line_counter] += "#{career}: #{terms} "
      end
    end
    line_counter        += 1
    lines[line_counter] =  ""
    lines[line_counter] += "#{character.appearence.capitalize} " if character.appearence
    line_counter        += 1
    lines[line_counter] =  ""
    lines[line_counter] += "Temperament: #{character.temperament.capitalize}   " if character.temperament
    lines[line_counter] += "Plot: #{character.plot[0].capitalize} (#{character.plot[-1]}) " if character.plot
    line_counter        += 1
    lines[line_counter] = ""
    lines[line_counter] += "Traits: #{character.traits.map(&:capitalize).join(', ')}" if character.traits
    line_counter        += 1
    lines[line_counter] =  ""
    if character.skills 
      character.skills.each_pair do |skill, level|
        lines[line_counter] += "#{skill}-#{level} "
      end
    end
    line_counter        += 1
    lines[line_counter] =  ""
    if character.stuff
      lines[line_counter] += "Cash: #{character.stuff["cash"]} " if character.stuff["cash"]
      if character.stuff["benefits"]
        character.stuff["benefits"].each do |k,v|
          lines[line_counter] +=  "#{k} (#{v}) "
        end
      end
    end

    lines.each do |line|
      puts line unless line.nil? || line.length == 0 
    end
  end
end
