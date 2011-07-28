#!/usr/bin/env ruby

# # Problem 32 #
#
# We shall say that an n-digit number is pandigital if it makes use of all the
# digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1
# through 5 pandigital.
#
# The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing
# multiplicand, multiplier, and product is 1 through 9 pandigital.
#
# Find the sum of all products whose multiplicand/multiplier/product identity
# can be written as a 1 through 9 pandigital.
#
# HINT: Some products can be obtained in more than one way so be sure to only
# include it once in your sum.

matches = []
for i in 1...10000 do
  for j in 1...10000 do
    k = i * j
    next if i.to_s.include?('0') or j.to_s.include?('0') or k.to_s.include?('0')
    length = i.to_s.length + j.to_s.length + k.to_s.length
    break if length > 9
    next unless length == 9
    digits = []
    i.to_s.each_char { |c| digits << c }
    j.to_s.each_char { |c| digits << c }
    k.to_s.each_char { |c| digits << c }
    matches << k if digits.uniq.size == 9 and !matches.include?(k)
  end
end

puts matches.inject(:+)

