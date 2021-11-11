#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

class Numeric
  def to_text() = to_s.rjust(8)
end

def wc_output(agv)
  lines = agv.lines.count
  words = agv.split.size
  bytesize = agv.bytesize
  [lines, words, bytesize]
end

def render(input, options)
  total_lines = 0
  total_words = 0
  total_bytesize = 0
  input.each do |agv|
    type = File.ftype(agv)
    if type != 'file'
      puts "wc: #{agv}: read: Is a #{type}"
    else
      file = File.read(agv)
      lines, words, bytesize = wc_output(file)
      options['l'] ? (print lines.to_text) : (print "#{lines.to_text}#{words.to_text}#{bytesize.to_text}")
      print " #{agv}\n"
      total_lines += lines
      next if options['l']

      total_words += words
      total_bytesize += bytesize
    end
  end
  puts(options['l'] ? "#{total_lines.to_text} total" : "#{total_lines.to_text}#{total_words.to_text}#{total_bytesize.to_text} total") if input.size > 1
end

def main
  options = ARGV.getopts('l')
  if ARGV.empty?
    input = $stdin.read
    lines, words, bytesize = wc_output(input)
    print "#{lines.to_text}#{words.to_text}#{bytesize.to_text}"
    puts
  else
    render(ARGV, options)
  end
end

main
