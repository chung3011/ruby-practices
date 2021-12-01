#!/usr/bin/env ruby
# frozen_string_literal: true

require './file_list'
require './opt_l_printer'
require './printer'

file_list = FileList.new(ARGV)

file_list.option_l ? OptLPrinter.output(file_list.list, file_list.path) : Printer.put(file_list.list)
