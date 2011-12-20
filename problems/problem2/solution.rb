#!/usr/bin/env ruby

def fibonacci
  a, b = 0, 1
  loop do
    a, b = b, a + b
    yield b
  end
end

sum = 0

fibonacci do |n|
  break if n > 4_000_000
  sum += n if n.even?
end

puts sum
