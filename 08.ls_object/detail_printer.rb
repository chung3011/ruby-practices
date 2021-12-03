# frozen_string_literal: true

require './file_info'

class DetailPrinter
  def self.output(list, path)
    list = path ? list.map { |f| "#{path}/#{f}" } : list
    blocks = list.map { |f| File::Stat.new(f).blocks }
    puts "total #{blocks.sum}"

    list.each do |f|
      file_info = FileInfo.new(f)
      print file_info.type
      print file_info.owner
      print file_info.group
      print file_info.other
      print file_info.nlink
      print file_info.owner_name
      print file_info.group_name
      print file_info.time_stamp
      print file_info.name
      puts
    end
  end
end
