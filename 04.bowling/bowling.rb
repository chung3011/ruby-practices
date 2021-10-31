#!/usr/bin/env ruby
# frozen_string_literal: true

def create_frames(score)
  frames = []
  score.split(',').each do |s|
    if s == 'X'
      frames.push(10, 0)
    else
      frames.push(s.to_i)
    end
  end
  frames.each_slice(2).to_a
end

def total_score(frames)
  point = 0
  frames.each_with_index do |frame, index|
    break if index == 10

    point += if frame[0] == 10 && frames[index + 1][0] == 10
               20 + frames[index + 2][0]
             elsif frame[0] == 10
               10 + frames[index + 1].sum
             elsif frame.sum == 10
               10 + frames[index + 1][0]
             else
               frame.sum
             end
  end
  puts point
end

def main
  score = ARGV[0]
  frames = create_frames(score)
  total_score(frames)
end

main
