# frozen_string_literal: true

class Printer
  COLUMNS = 3
  def self.put(list)
    rows = (list.size.to_f / COLUMNS).ceil
    rows.times do |row|
      COLUMNS.times do |col|
        break if row + rows * col >= list.size

        print list[row + rows * col].ljust(20)
      end
      puts
    end
  end
end
