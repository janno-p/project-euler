#!/usr/bin/env ruby

# # Problem 96 #
#
# Su Doku (Japanese meaning number place) is the name given to a popular puzzle
# concept. Its origin is unclear, but credit must be attributed to Leonhard
# Euler who invented a similar, and much more difficult, puzzle idea called
# Latin Squares. The objective of Su Doku puzzles, however, is to replace the
# blanks (or zeros) in a 9 by 9 grid in such that each row, column, and 3 by 3
# box contains each of the digits 1 to 9. Below is an example of a typical
# starting puzzle grid and its solution grid.
#
#   0 0 3 | 0 2 0 | 6 0 0    4 8 3 | 9 2 1 | 6 5 7
#   9 0 0 | 3 0 5 | 0 0 1    9 6 7 | 3 4 5 | 8 2 1
#   0 0 1 | 8 0 6 | 4 0 0    2 5 1 | 8 7 6 | 4 9 3
#   ------+-------+------    ------+-------+------
#   0 0 8 | 1 0 2 | 9 0 0    5 4 8 | 1 3 2 | 9 7 6
#   7 0 0 | 0 0 0 | 0 0 8    7 2 9 | 5 6 4 | 1 3 8
#   0 0 6 | 7 0 8 | 2 0 0    1 3 6 | 7 9 8 | 2 4 5
#   ------+-------+------    ------+-------+------
#   0 0 2 | 6 0 9 | 5 0 0    3 7 2 | 6 8 9 | 5 1 4
#   8 0 0 | 2 0 3 | 0 0 9    8 1 4 | 2 5 3 | 7 6 9
#   0 0 5 | 0 1 0 | 3 0 0    6 9 5 | 4 1 7 | 3 8 2
#
# A well constructed Su Doku puzzle has a unique solution and can be solved by
# logic, although it may be necessary to employ "guess and test" methods in
# order to eliminate options (there is much contested opinion over this). The
# complexity of the search determines the difficulty of the puzzle; the example
# above is considered easy because it can be solved by straight forward direct
# deduction.
#
# The 6K text file, sudoku.txt (right click and 'Save Link/Target As...'),
# contains fifty different Su Doku puzzles ranging in difficulty, but all with
# unique solutions (the first puzzle in the file is the example above).
#
# By solving all fifty puzzles find the sum of the 3-digit numbers found in the
# top left corner of each solution grid; for example, 483 is the 3-digit number
# found in the top left corner of the solution grid above.

class Array
  def values
    select { |item| item.is_a?(Item) and item.known? }.collect { |item| item.value }
  end
end

class Item
  attr_reader :value, :possible, :box, :column, :row
  
  def initialize(value, box, column, row)
    @value = (value == 0 ? nil : value)
    @possible = (1..9).to_a
    @box = box << self
    @column = column << self
    @row = row << self
  end
  
  def known?
    !@value.nil?
  end
  
  def update_single
    @possible -= (@box.values + @column.values + @row.values)
    @value = @possible[0] if @possible.size == 1
    known?
  end
  
  def update_exclude
    return true if check_for_single_possible_value(@box)
    return true if check_for_single_possible_value(@column)
    return true if check_for_single_possible_value(@row)
    false
  end
  
  def check_for_single_possible_value(list)
    @possible.each do |v|
      if list.select { |i| i != self and !i.known? and i.possible.include?(v) }.size == 0
        @value = v
        return true
      end
    end
    false
  end
end

class Grid
  def self.from_file(file)
    name = file.gets
    return nil unless name
    name.strip
    matrix = 9.times.inject([]) { |m, i| m += file.gets.strip.split(//).collect { |n| n.to_i } }
    Grid.new(name, matrix)
  end
  
  def initialize(name, matrix)
    @name = name
    @boxes = 9.times.collect { [] }
    @columns = 9.times.collect { [] }
    @rows = 9.times.collect { [] }
    @unknown_items = []
    parse(matrix)
  end
  
  def solve
    loop do
      has_changed = false
      while update_unknown { |item| item.update_single }
        has_changed = true
      end
      while update_unknown { |item| item.update_exclude }
        has_changed = true
      end
      break unless has_changed
    end
    @unknown_items.empty?
  rescue Exception => e
    puts e
    false
  ensure
    print
  end
  
  def print
    puts @name
    @rows.each { |row| puts row.collect { |item| item.value || '_' }.join(',') }
  end
  
private
  
  def parse(matrix)
    matrix.each_with_index do |value, index|
      item = Item.new(
        value,
        @boxes[3 * ((index / 9) / 3) + ((index % 9) / 3)],
        @columns[index % 9],
        @rows[index / 9])
      @unknown_items << item unless item.known?
    end
  end
  
  def update_unknown
    known_items = @unknown_items.select { |item| yield item }
    @unknown_items -= known_items
    known_items.any?
  end
end

File.open('data/problem96_sudoku.txt', 'r') do |file|
  failed_count = 0
  while (solver = Grid.from_file(file))
    failed_count += 1 unless solver.solve
    puts
  end
  puts "Failed solutions: #{failed_count}"
end

