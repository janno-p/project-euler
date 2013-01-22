#!/usr/bin/env ruby

require 'mathn'
require 'set'

prime_factors = Set.new
number = 600_851_475_143

Prime.each do |prime|
  break unless number > 1
  while number % prime == 0 do
    number /= prime
    prime_factors << prime
  end
end

puts prime_factors.max
