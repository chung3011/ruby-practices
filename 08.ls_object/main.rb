#!/usr/bin/env ruby
# frozen_string_literal: true

require './file_list'

file_list = FileList.new(ARGV)
file_list.output
