#!/usr/bin/env ruby
# frozen_string_literal: true

require './game'
require './input'

unless ARGV[0].nil?
  score = Input.enqueue
  p Game.new(score).total_score
end
