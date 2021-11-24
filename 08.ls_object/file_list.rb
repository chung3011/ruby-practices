# frozen_string_literal: true

require 'optparse'
require './file_info'

class FileList
  attr_reader :list, :option_l, :path

  COLUMNS = 3

  def initialize(argv)
    options = argv.getopts('a', 'r', 'l')
    base = argv.empty? ? '' : argv[0]&.to_s
    flags = options['a'] ? File::FNM_DOTMATCH : 0
    @list = Dir.glob('*', flags, base: base).sort
    @list.reverse! if options['r']
    @option_l = true if options['l']
    @path = argv[0]
  end

  def output
    @option_l ? print_opt_l : print_list
  end

  private

  def print_list
    rows = (@list.size.to_f / COLUMNS).ceil
    rows.times do |row|
      COLUMNS.times do |col|
        break if row + rows * col >= @list.size

        print @list[row + rows * col].ljust(20)
      end
      puts
    end
  end

  def print_opt_l
    @list = @path ? @list.map { |f| "#{@path}/#{f}" } : @list
    blocks = @list.map { |f| File::Stat.new(f).blocks }
    puts "total #{blocks.sum}"

    @list.each do |f|
      file_info = FileInfo.new(f)
      file_info.output
    end
  end
end
