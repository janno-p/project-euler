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

class Item
  attr_accessor :value, :possible_values
  attr_reader :box, :column, :row
  
  def initialize(box, column, row)
    @box = box
    @box << self
    @column = column
    @column << self
    @row = row
    @row << self
  end
end

class SuDokuSolver
  attr_reader :boxes, :columns, :rows
  
  def initialize(matrix)
    @boxes = 9.times.collect { [] }
    @columns = 9.times.collect { [] }
    @rows = 9.times.collect { [] }
    matrix.each_with_index do |value, index|
      item = Item.new(
        boxes[3 * ((index / 9) / 3) + ((index % 9) / 3)],
        columns[index % 9],
        rows[index / 9])
      item.value = value unless value == 0
    end    
  end
end

File.open('data/problem96_sudoku.txt', 'r') do |file|
  while (line = file.gets)
    matrix = 9.times.inject([]) { |m,i| m += file.gets.strip.split(//).collect { |n| n.to_i } }
    solver = SuDokuSolver.new(matrix)
    break
  end
end



=begin

def get_row(matrix, index)
  first = index - index % 9
  matrix[first...(first + 9)]
end

def get_column(matrix, index)
  (index % 9).step(matrix.size - 1, 9).collect { |i| matrix[i] }
end

def block_index(index)
  first = (index / 9 / 3) * 27 + ((index % 9) / 3) * 3
  r = []
  3.times do
    3.times { r << first ; first += 1 }
    first += 6
  end
  r
end

def get_block(matrix, index)
  block_index(index).collect { |i| matrix[i] }
end

def print_grid(matrix)
  matrix.each_with_index do |v, i|
    if i > 0
      if i % 9 == 0 then puts
      elsif i % 3 == 0 then print '| '
      end
      puts '------+-------+------' if i % 27 == 0
    end
    print "#{v.is_a?(Array) ? (v.size == 0 ? 0 : '[' + v.join('/') + ']') : v} "
  end
  puts
end

def fill_unknown(matrix)
  for i in 0...matrix.size do
    next unless matrix[i].is_a?(Array)
    used = get_block(matrix, i) + get_row(matrix, i) + get_column(matrix, i)
    matrix[i] = [1,2,3,4,5,6,7,8,9] - used
  end
end

def replace_single(matrix)
  for i in 0...matrix.size do
    next unless matrix[i].is_a?(Array) and matrix[i].size == 1
    matrix[i] = matrix[i].first
  end
end

def do_step(matrix)
  puts
  fill_unknown(matrix)
  replace_single(matrix)
  print_grid(matrix)
end

File.open('data/problem96_sudoku.txt', 'r') do |file|
  while (line = file.gets)
    matrix = read_grid(file)
    print_grid(matrix)
    do_step(matrix)
    do_step(matrix)
    do_step(matrix)
    do_step(matrix)
    do_step(matrix)
    do_step(matrix)
    do_step(matrix)
    do_step(matrix)
    do_step(matrix)
    do_step(matrix)
    break
  end
end

=end
