#!/usr/bin/env ruby

# Thanks to apeiros (Freenode#ruby) for the simple code line.
require 'optparse'
require 'shellwords'

def run_sub(options)
  words = options[:list]
  begin
    in_text = File.read(options[:input]) 
  rescue SystemCallError => e
    puts e.message
    exit
  end 
  after = in_text.gsub(Regexp.union(words.keys), words)
  begin
    out_file = File.open(options[:output], 'w')
    out_file.write(after)
    out_file.close()
  rescue SystemCallError => e
    puts e.message
    exit
  end
end

def set_word_list(list)
  word_list = Hash.new(0)
  l_file    = File.open(list)
  l_file.each_line do |line|
    if line.length > 3
      line_array = Shellwords.shellwords(line)
      word_list[line_array[0]] = line_array[1]
    end
  end
  return word_list
end

options = Hash.new(0)
option_parser = OptionParser.new do |opts|
  opts.on('-l', '--list LIST', 'List of words to change') do |list|
    options[:list] = set_word_list(list)
  end
  opts.on('-i', '--input INPUT', 'Input file') do |input|
    options[:input] = input
  end
  opts.on('-o', '--output OUTPUT', 'Output file') do |output|
    options[:output] = output
  end
end
option_parser.parse!

### Main bit
run_sub(options)
