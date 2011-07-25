#!/usr/bin/env ruby

# # Problem 81 #
#
# In the 5 by 5 matrix below, the minimal path sum from the top left to the
# bottom right, by only moving to the right and down, is indicated in bold red
# and is equal to 2427.
#
#   [131]  673   234   103    18
#   [201] [ 96] [342]  965   150
#    630   803  [746] [422]  111
#    537   699   497  [121]  956
#    805   732   524  [ 37] [331]
#
# Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target
# As...'), a 31K text file containing a 80 by 80 matrix, from the top left to
# the bottom right by only moving right and down.

test_matrix = [
  [131, 673, 234, 103, 18],
  [201, 96, 342, 965, 150],
  [630, 803, 746, 422, 111],
  [537, 699, 497, 121, 956],
  [805, 732, 524, 37, 331]
]

matrix = []
File.open('data/problem81_matrix.txt', 'r') do |file|
  file.readlines.each do |line|
    matrix << line.split(',').collect { |token| token.to_i }
  end
end

# For testing
matrix = test_matrix

# Assuming we have square matrix
dimension = matrix.size - 1

x, y, best = 0, 0, matrix[0][0]
while x < dimension or y < dimension
  if x == dimension
    y += 1
  elsif y == dimension
    x += 1
  elsif matrix[x + 1][y] > matrix[x][y + 1]
    y += 1
  else
    x += 1
  end
  best += matrix[x][y]
end

for x in 0...dimension do
  for y in 0...dimension do
    
  end
end

puts best
