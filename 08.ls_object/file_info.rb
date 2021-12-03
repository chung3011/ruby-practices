# frozen_string_literal: true

require 'etc'

class FileInfo
  attr_reader :type, :owner, :group, :other, :nlink, :owner_name, :group_name, :size, :time_stamp, :name

  def initialize(file)
    status = File::Stat.new(file)
    @type = file_type(File.ftype(file))
    mode = status.mode.to_s(8)
    @owner = file_permission(mode[-3])
    @group = file_permission(mode[-2])
    @other = file_permission(mode[-1])
    @nlink = status.nlink.to_s.rjust(2)
    @owner_name = Etc.getpwuid(status.uid).name.to_s.rjust(10)
    @group_name = Etc.getgrgid(status.gid).name.to_s.rjust(6)
    @size = status.size.to_s.rjust(5)
    @time_stamp = status.mtime.strftime(' %b %e %H:%M ').rjust(10)
    @name = File.basename(file)
  end

  private

  def file_type(type)
    {
      'fifo' => 'p',
      'characterSpecial' => 'c',
      'directory' => 'd',
      'blockSpecial' => 'b',
      'file' => '-',
      'link' => 'l',
      'socket' => 's'
    }[type]
  end

  def file_permission(mode)
    {
      '0' => '---',
      '1' => '--x',
      '2' => '-w-',
      '3' => '-wx',
      '4' => 'r--',
      '5' => 'r-x',
      '6' => 'rw-',
      '7' => 'rwx'
    }[mode]
  end
end
