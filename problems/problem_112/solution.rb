#!/usr/bin/env ruby

def bouncy?(num)
  arr = num.to_s.split(//).map(&:to_i)
  arr_sorted = arr.sort
  arr != arr_sorted and arr.reverse != arr_sorted
end

num_bouncies = 0
num = 0

loop do
  num += 1
  num_bouncies += 1 if bouncy?(num)
  break if num_bouncies * 100 == 99 * num
end

puts num
