class Dice

  def roll_1
    rand(1..6)
  end

  def roll_2
    self.roll_1 + self.roll_1
  end
  
  def roll_66
    roll = self.roll_1.to_s + self.roll_1.to_s
    return roll.to_i
  end

end
