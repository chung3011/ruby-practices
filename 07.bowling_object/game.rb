# frozen_string_literal: true

require './frame'

class Game
  attr_reader :frames

  def initialize(score)
    @frames = score.map { |frame| Frame.new(frame[0], frame[1]) }
  end

  def total_score
    @frames.each_with_index.sum do |frame, index|
      next 0 if index >= 10

      if frame.strike? && @frames[index + 1].strike?
        frame.score + @frames[index + 1].score + @frames[index + 2].first_shot.score
      elsif frame.strike?
        frame.score + @frames[index + 1].score
      elsif frame.spare?
        frame.score + @frames[index + 1].first_shot.score
      else
        frame.score
      end
    end
  end
end
