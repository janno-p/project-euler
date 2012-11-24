#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'common', 'fraction.rb')
require File.join(File.dirname(__FILE__), '..', 'common', 'prime_generator.rb')

def prime_ratio(factors)
  result = Fraction::Zero
  for n in 1..factors.size do
    sub_result = Fraction::Zero
    factors.combination(n).each do |c|
      sub_result = sub_result + Fraction.new(1, c.inject(:*))
    end
    if n % 2 == 0 then
      result = result - sub_result
    else
      result = result + sub_result
    end
  end
  Fraction.new(1) - result
end

factors = []
prime_generator = PrimeGenerator.new
target_resilience = Fraction.new(15499, 94744)

last_number = 0
last_resilience = Fraction::Zero

loop do
  factors << prime_generator.next
  number = factors.inject(:*)
  ratio = prime_ratio(factors)
  resilience = Fraction.new(ratio.numerator * (number / ratio.denominator), number - 1)
  break if resilience < target_resilience
  last_number = number
  last_resilience = resilience
end

for i in 2...factors.max do
  resilience = Fraction.new(last_resilience.numerator * i, last_number * i - 1)
  if resilience < target_resilience then
    puts last_number * i
    exit
  end
end
