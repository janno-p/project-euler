#!/usr/bin/env ruby

def palindrome?(num)
  num_str = num.to_s
  num_size = num_str.size
  num_str.start_with?(num_str[-(num_size / 2)..-1].reverse)
end

max = 0

999.downto(100) do |x|
  999.downto(x) do |y|
    num = x * y
    max = num if palindrome?(num) and num > max
  end
end

puts max
