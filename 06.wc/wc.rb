#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

class Numeric
  def to_text() = to_s.rjust(8)
end

def info(agv)
  lines = agv.lines.count
  words = agv.split.size
  bytesize = agv.bytesize
  [lines, words, bytesize]
end

def render(input)
  total_lines = 0
  total_words = 0
  total_bytesize = 0
  input.each do |agv|
    type = File.ftype(agv)
    if type != 'file'
      puts "wc: #{agv}: read: Is a #{type}"
    else
      file = File.read(agv)
      output = info(file)
      output.each { |o| print o.to_text }
      print " #{agv}\n"
      total_lines += output[0]
      total_words += output[1]
      total_bytesize += output[2]
    end
  end
  puts "#{total_lines.to_text}#{total_words.to_text}#{total_bytesize.to_text} total" if input.size > 1
end

def main
  if ARGV.empty?
    input = $stdin.read
    output = info(input)
    output.each { |o| print o.to_text }
    puts
  else
    render(ARGV)
  end
end

main
