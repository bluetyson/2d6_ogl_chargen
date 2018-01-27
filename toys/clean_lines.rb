
require "optparse"

options     = Hash.new(0)

parser = OptionParser.new do |opts|
  opts.on("-i FILE", "Input file") do |file|  
    if File.exists?(file)
      options[:in_file] = File.open(file, 'r')
    end
  end
  opts.on("-o FILE", "Output file") do |file|
    options[:out_file] = File.open(file, 'w')
  end
end
parser.parse!

in_file   = options[:in_file]
out_file  = options[:out_file]

in_file.each do |line|
  line = line.strip()
  line.gsub!(/[",]/, '')
  out_file.puts(line)
end
in_file.close()
out_file.close()
