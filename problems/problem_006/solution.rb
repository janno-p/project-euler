#!/usr/bin/env ruby

sum = 0
sum_squares = 0

(1..100).each do |i|
  sum += i
  sum_squares += i ** 2
end

puts (sum ** 2 - sum_squares)
