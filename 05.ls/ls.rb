#!/usr/bin/env ruby
# frozen_string_literal: true

directory = ARGV
COLUMNS = 3

def file_list(directory)
  list = directory.empty? ? Dir['*'].sort : Dir["#{directory[0]}/*"].sort.map { |fname| fname[(directory[0].length + 1)..] }
  print_list(list, COLUMNS)
end

def print_list(list, columns)
  rows = (list.size.to_f / columns).ceil
  (1..rows).each do |row_index|
    (1..columns).each do |column_index|
      break if row_index + rows * (column_index - 1) > list.size

      print list[row_index + rows * (column_index - 1) - 1].ljust(20)
    end
    puts
  end
end

file_list(directory)
