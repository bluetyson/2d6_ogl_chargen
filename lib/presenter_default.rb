module PresenterDefault
  
  def PresenterDefault.show(character)
    lines = Array.new
    lines[0] =  ""
    lines[0] += "#{character.title} " if character.noble?
    lines[0] += "#{character.rank} "  if character.rank
    lines[0] += "#{character.name} "  if character.name
    lines[0] += "#{character.gender} "  if character.gender
    lines[0] += "Age: #{character.age} "   if character.age
    lines[0] += "#{character.upp.to_s} "   if character.upp
    character.careers.each_pair do |career, terms|
      lines[0] += "#{career}: #{terms} "
    end
    lines[2] =  ""
    lines[2] += "#{character.appearence.capitalize} " if character.appearence
    lines[3] =  ""
    lines[3] += "Temperament: #{character.temperament.capitalize}   " if character.temperament
    lines[3] += "Plot: #{character.plot[0].capitalize} (#{character.plot[-1]}) " if character.plot
    lines[4] = ""
    lines[4] += "Traits: #{character.traits.map(&:capitalize).join(', ')}" if character.traits
    lines[5] =  ""
    if character.skills 
      character.skills.each_pair do |skill, level|
        lines[5] += "#{skill}-#{level} "
      end
    end
    lines[6] =  ""
    lines[6] += "Cash: #{character.stuff["cash"]} " if character.stuff
    #character.stuff["benefits"].each do |k,v|
    #  lines[6] +=  "#{k} (#{v}) "
    #end

    lines.each do |line|
      puts line unless line.nil? || line.length == 0 
    end
  end
end
