# frozen_string_literal: true

class Input
  def self.enqueue
    score = []
    ARGV[0].split(',').each do |s|
      if s == 'X'
        score.push(10, 0)
      else
        score.push(s.to_i)
      end
    end
    score.each_slice(2).to_a
  end
end
