module PresenterCSV

  def PresenterCSV.show(character)
    first_career = true
    first_skill = true
    line = []
    if character.noble?
      line << character.title
    else
      line << ""
    end
    line << character.name.split()[0]
    line << character.name.split()[1]
    line << character.gender
    line << character.age
    line << character.upp
    line << character.appearence.capitalize
    line << character.temperament.capitalize
    plot_line = "#{character.plot[0].capitalize} (#{character.plot[1]})"
    line << plot_line
    traits_line = character.traits.map(&:capitalize).join(', ')
    line << traits_line
    careers = ""
    character.careers.each_pair do |career, terms|
      careers << "," if first_career == false
      first_career = false
      careers << "#{career}-#{terms}"
    end
    line << careers
    skills = ""
    if character.skills 
      character.skills.each_pair do |skill, level|
        skills << "," if first_skill == false
        first_skill = false
        skills << "#{skill}-#{level}"
      end
      line << skills
      line << character.stuff['cash']
      benefit_line = ""
      character.stuff["benefits"].each do |k,v|
        benefit_line << "#{k} (#{v}) "
      end  
      line << benefit_line
    end
    puts line.join(":")
  end
end
