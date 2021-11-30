# frozen_string_literal: true

require 'optparse'
require './opt_l'
require './printer'

class FileList
  attr_reader :list, :option_l, :path

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
    @option_l ? OptL.output(@list, @path) : Printer.put(@list)
  end
end
