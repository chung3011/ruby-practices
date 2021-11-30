# frozen_string_literal: true

require './file_info'

class OptL
  def self.output(list, path)
    list = path ? list.map { |f| "#{path}/#{f}" } : list
    blocks = list.map { |f| File::Stat.new(f).blocks }
    puts "total #{blocks.sum}"

    list.each do |f|
      file_info = FileInfo.new(f)
      file_info.output
    end
  end
end
