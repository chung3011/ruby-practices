#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMNS = 3

def file_list(directory)
  options = ARGV.getopts('a')
  list = if options['a']
           directory.empty? ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*', File::FNM_DOTMATCH, base: directory[0]&.to_s).sort
         else
           directory.empty? ? Dir.glob('*').sort : Dir.glob('*', base: directory[0]&.to_s).sort
         end
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
