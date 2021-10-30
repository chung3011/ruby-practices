#!/usr/bin/env ruby
# frozen_string_literal: true

directory = ARGV
COLUMNS = 3

def file_list(directory)
  list = directory.empty? ? Dir.glob('*').sort : Dir.glob('*', base: (directory[0]).to_s).sort
  print_list(list, COLUMNS)
end

def print_list(list, columns)
  rows = (list.size.to_f / columns).ceil
  rows.times do |row|
    columns.times do |col|
      break if row + 1 + rows * col > list.size

      print list[row + rows * col].ljust(20)
    end
    puts
  end
end

file_list(directory)
