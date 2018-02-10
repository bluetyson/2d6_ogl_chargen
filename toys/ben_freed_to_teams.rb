
# ben_freed_to_teams.rb

counter = 0
teams = Array.new

def comma_to_colon(line)
  in_quote  = false
  new_line  = ''
  line.each_char { |c|
    if c == '"'
      c = ''
      if not in_quote
        in_quote = true
      else
        in_quote = false
      end
    end
    if not in_quote
      c = ':' if c == ','
    end
    new_line += c
  }
  return new_line
end

File.open('data/ben_freed_slaves2.csv', 'r').each_line { |line|
  line = line.strip()
  line = comma_to_colon(line)
  if teams.length == counter
    teams[counter] = Array.new
  end
  if line.match?('Abandonment') 
    if counter == 6
      counter = 0 
    end
    teams[counter] << line
    counter += 1
  end
}

team_counter = 0
teams.each { |team|
  next if team.length < 2
  filename = "data/team_#{team_counter}.csv"
  File.open(filename, 'w') { |f|
    teams[team_counter].each { |line|
      f.puts line
    }
  }
  team_counter += 1
}

