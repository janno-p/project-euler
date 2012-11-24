#!/usr/bin env ruby

require File.join(File.dirname(__FILE__), '..', 'common', 'fraction.rb')

def get_fraction(n)
  c = n - 1
  k = n / 3

  fraction = Fraction::Zero

  (c - 1).downto(0) do |i|
    if i % 3 == 1 then
      fraction = Fraction.new(2 * k, 1) + fraction
      fraction = Fraction.new(1) / fraction
      k -= 1
    else
      fraction = Fraction.new(1) + fraction
      fraction = Fraction.new(1) / fraction
    end
  end
  
  fraction += Fraction.new(2)
end

puts get_fraction(100).numerator.to_s.split(//).map(&:to_i).inject(:+)
