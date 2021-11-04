#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMNS = 3

def file_list(directory)
  options = ARGV.getopts('a')
  base = directory.empty? ? '' : directory[0]&.to_s
  flags = options['a'] ? File::FNM_DOTMATCH : 0
  list = Dir.glob('*', flags, base: base).sort
  print_list(list, COLUMNS)
end

def print_list(list, columns)
  rows = (list.size.to_f / columns).ceil
  rows.times do |row|
    columns.times do |col|
      break if row + rows * col >= list.size

      print list[row + rows * col].ljust(20)
    end
    puts
  end
end

file_list(ARGV)
