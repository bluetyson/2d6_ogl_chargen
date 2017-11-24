module Dice

  def self.roll_dice(dice_type, dice_number, average_of = 1)
    total = 0.0 
    dice_number.times do
      average_total = 0
      average_of.times do
        average_total += rand(dice_type) + 1
      end
      total += (average_total / average_of).round 
    end
    return total.to_i
  end
end
