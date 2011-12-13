#!/usr/bin/env ruby

# If a ** x ~ b ** y is true (where ~ is >, <, ==, etc.)
# then x * log(a) ~ y * log(b) is also true

line_index, best_index, best_value = 0, 0, 0

File.readlines(File.join(File.dirname(__FILE__), '..', 'data', 'base_exp.txt')).each do |line|
  line_index += 1
  base, power = line.strip.split(',').map(&:to_i)
  line_value = power * Math.log10(base)
  best_index, best_value = line_index, line_value if line_value > best_value
end

puts best_index
