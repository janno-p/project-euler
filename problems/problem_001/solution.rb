#!/usr/bin/env ruby

max = 1000
sum = 0

0.step(max - 1, 3) { |i| sum += i }
0.step(max - 1, 5) { |i| sum += i unless i % 3 == 0 }

puts sum
