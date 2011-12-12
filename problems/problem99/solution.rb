#!/usr/bin/env ruby

base_a = 632382
power_a = 518061

base_b = 519432
power_b = 525806

def pow(base, power, pots)
  mask = []
  current = power
  pots.each_with_index do |pot, index| # =>
    new_current = current - pot
    if new_current >= 0 then
      mask << pots.size - index - 1
      current = new_current
    end
    break if current == 0
  end
  result = 1
  current = base
  for i in 0..mask.max do
    result *= current if mask.include?(i)
    current *= current
  end
  result
end

max_line = 0
pots = (0..24).to_a.reverse.map { |i| 2 ** i }
File.readlines(File.join(File.dirname(__FILE__), '..', 'data', 'base_exp.txt')).each do |line|
  base, power = line.strip.split(',').map(&:to_i)
end

puts max_line
