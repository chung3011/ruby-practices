#!/usr/bin/env ruby
# frozen_string_literal: true

require './file_list'
require './detail_printer'
require './name_printer'

file_list = FileList.new(ARGV)

file_list.option_l ? DetailPrinter.output(file_list.list, file_list.path) : NamePrinter.put(file_list.list)
