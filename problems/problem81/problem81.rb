#!/usr/bin/env ruby

# # Problem 81 #
#
# In the 5 by 5 matrix below, the minimal path sum from the top left to the
# bottom right, by only moving to the right and down, is indicated in bold red
# and is equal to 2427.
#
#   131* 673  234  103   18
#   201*  96* 342* 965  150
#   630  803  746* 422* 111
#   537  699  497  121* 956
#   805  732  524   37* 331*
#
# Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target
# As...'), a 31K text file containing a 80 by 80 matrix, from the top left to
# the bottom right by only moving right and down.

matrix = []
File.open('data/problem81_matrix.txt', 'r') do |file|
  file.readlines.each do |line|
    matrix << line.split(',').collect { |token| token.to_i }
  end
end

num_rows = 2 * matrix.size - 1
for row in 0...num_rows do
  min_col = [row - matrix.size + 1, 0].max
  max_col = [row, matrix.size - 1].min
  for col in min_col..max_col do
    x, y = col, row - col
    val1 = x > 0 ? matrix[x - 1][y] : nil
    val2 = y > 0 ? matrix[x][y - 1] : nil
    next unless val1 or val2
    matrix[x][y] += [val1 || val2, val2 || val1].min
  end
end

puts matrix[-1][-1]
