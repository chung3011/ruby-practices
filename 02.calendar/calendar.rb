#!/usr/bin/env ruby

require 'date'
require 'optparse'

class String
  def text_red; "\e[31m#{self}\e[0m" end
end

def check_month(month)
  (1..12).include?(month) ? month : Date.today.month
end

def check_year(year)
  year == 0 ? Date.today.year : year
end

params = ARGV.getopts("m:","y:")
year = check_year(params["y"].to_i)
month = check_month(params["m"].to_i)

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)

puts "#{month}月 #{year}".center(20)
puts " 日 月 火 水 木 金 土"

first_day.wday.times { print "   " }

(first_day..last_day).each do |day|
  date = day == Date.today ? day.mday.to_s.rjust(3).text_red : day.mday.to_s.rjust(3)
  print day.saturday? ? date+"\n" : date
end

print "\n"
