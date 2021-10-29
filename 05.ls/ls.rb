#!/usr/bin/env ruby
# frozen_string_literal: true

directory = ARGV
COLUMNS = 3

def file_list(directory)
  list = directory.empty? ? Dir.glob('*').sort : Dir.glob("#{directory[0]}/*").sort.map { |fname| fname[(directory[0].length + 1)..] }
  print_list(list, COLUMNS)
end

def print_list(list, columns)
  rows = (list.size.to_f / columns).ceil
  list = list.each_slice(rows).map { |n| n }
  rows.times do |row|
    columns.times do |col|
      print list[col][row].to_s.ljust(20)
    end
    puts
  end
end

file_list(directory)
