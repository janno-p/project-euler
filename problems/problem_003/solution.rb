#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'common', 'prime_generator.rb')

generator = PrimeGenerator.new

prime_factors = []
number = 600_851_475_143

while number > 1 do
  prime = generator.next
  count = 0
  while number % prime == 0 do
    number /= prime
    count += 1
  end
  prime_factors << prime if count > 0
end

puts prime_factors.max
