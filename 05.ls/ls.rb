#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

COLUMNS = 3

def file_list(directory)
  options = ARGV.getopts('a', 'r', 'l')
  base = directory.empty? ? '' : directory[0]&.to_s
  flags = options['a'] ? File::FNM_DOTMATCH : 0
  list = Dir.glob('*', flags, base: base).sort
  list.reverse! if options['r']
  options['l'] ? print_opt_l(list) : print_list(list, COLUMNS)
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

def print_opt_l(list)
  list = ARGV[0] ? list.map { |f| "#{ARGV[0]}/#{f}" } : list
  @blocks = list.map { |f| File::Stat.new(f).blocks }
  puts "total #{@blocks.sum}"

  list.each do |f|
    status = File::Stat.new(f)
    type = file_type(File.ftype(f))
    mode = status.mode.to_s(8)
    owner = file_permission(mode[-3])
    group = file_permission(mode[-2])
    other = file_permission(mode[-1])
    nlink = status.nlink.to_s.rjust(2)
    owner_name = Etc.getpwuid(status.uid).name.to_s.rjust(10)
    group_name = Etc.getgrgid(status.gid).name.to_s.rjust(6)
    size = status.size.to_s.rjust(5)
    time_stamp = status.mtime.strftime(' %b%e %H:%M').rjust(10)
    name = File.basename(f)
    puts "#{type}#{owner}#{group}#{other}#{nlink}#{owner_name}#{group_name}#{size}#{time_stamp} #{name}"
  end
end

def file_type(type)
  {
    'fifo' => 'p',
    'characterSpecial' => 'c',
    'directory' => 'd',
    'blockSpecial' => 'b',
    'file' => '-',
    'link' => 'l',
    'socket' => 's'
  }[type]
end

def file_permission(mode)
  {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }[mode]
end

file_list(ARGV)
