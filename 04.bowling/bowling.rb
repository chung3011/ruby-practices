#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]

def check_valid(score)
  if score.nil?
    false
  else
    scores = []
    score.split(',').each do |s|
      if s == 'X'
        scores.push(10, 0)
      else
        scores.push(s.to_i)
      end
    end

    frames = scores.each_slice(2).to_a
    frames.each { |frame| return false if frame.sum > 10 }
  end
end

frames = check_valid(score)

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

frames ? total_score(frames) : (puts 'invalid score')
