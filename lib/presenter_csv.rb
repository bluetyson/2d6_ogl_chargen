module PresenterCSV


  def PresenterCSV.show(character)
    first_career = true
    first_skill = true
    print "#{character.name}:"
    print "#{character.upp}:"
    print "#{character.age}:"
    character.careers.each_pair do |career, terms|
      print "," if first_career == false
      first_career = false
      print "#{career}-#{terms}"
    end
    print":"
    if character.skills 
      character.skills.each_pair do |skill, level|
        print "," if first_skill == false
        first_skill = false
        print "#{skill}-#{level}"
      end
    end
    print":"
  end
end
