#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'common', 'fraction.rb')

limit = Fraction.new(3, 7)

current_best = Fraction.new(0)
for i in 1..1_000_000 do
  fraction = Fraction.new(i * limit.numerator / limit.denominator, i)
  current_best = fraction if fraction > current_best and fraction < limit
end

puts current_best.numerator
