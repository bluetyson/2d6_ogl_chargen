# planet.rb
# 
class Planet
  attr_accessor :name, :uwp
  attr_reader   :tl, :trade_codes, :gdp_trade_code_modifier

  def initialize(name, uwp)
    @name       = name
    @uwp        = uwp
    @port       = uwp[0]
    @size       = uwp[1].to_i(36)
    @atmo_num   = uwp[2].to_i(36)
    @hydro_num  = uwp[3].to_i(16)
    @hydro_perc = uwp[3].to_i(16) * 10
    @pop_num    = uwp[4].to_i(36)
    @gov_num    = uwp[5].to_i(36)
    @law_num    = uwp[6].to_i(36)
    @tl         = uwp[8].to_i(36)
    set_trade_codes
  end

  def atmo_label
    atmos   = ["None", "Trace", "Very Thin, Tainted", "Very Thin",
      "Thin, Tainted", "Thin", "Standard", "Standard, Tainted", 
      "Dense", "Dense, Tainted", "Exotic", "Corrosive", 
      "Dense, High", "Thin, Low", "Unusual"]
    @atmo_label   = atmos[@atmo_num]
  end

  def pop_label
    pops      = ["None", "Few", "Hundreds", "Thousands", 
      "Tens of Thousands", "Hundreds of Thousands", "Millions",
      "Tens of Millions", "Hundreds of Millions", "Billions",
      "Tens of Billions", "Hundreds of Billions", "Trillions"]
    @pop_label = pops[@pop_num]
  end

  def base_gdp
    gdp_numbers = [10, 40, 60, 80, 300, 500, 700, 2200, 2800, 3400,
      4400, 5200, 6000, 8000, 9000, 10000]
    gdp_numbers[@tl]
  end 

  def set_trade_codes
    @trade_codes = []
    @trade_codes << "Lt" if @tl <= 5
    @trade_codes << "Ag" if (4..9) === @atmo_num and (4..8) === @hydro_num and (5..7) === @pop_num
    @trade_codes << "NI" if (4..6) === @pop_num
    gdp_trade_code_modifier(@trade_codes)
  end
 
  def rand_gdp_variation
    @rand_gdp_variation = (rand(0..5) * -10) + (rand(0..5) * 10)
  end 
  
  def gdp_trade_code_modifier(trade_codes)
    gdp_tc_mods = {
      "Ag"  => 1.2,
      "NI"  => 0.7
    }
    trade_code_total = 0
    trade_codes.each do |tc|
      if gdp_tc_mods.has_key?(tc) 
        trade_code_total += gdp_tc_mods[tc]
      end
    end
    @gdp_trade_code_modifier = trade_code_total.to_f / trade_codes.length
  end

  def gdp(pop)
    @gdp = base_gdp * @gdp_trade_code_modifier * pop
  end  
end
