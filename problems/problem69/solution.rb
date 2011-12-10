#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../common/primes'

include Primes

# p[i] is prime factor of the number
# φ(n) = n * (1 - 1 / p[1]) * (1 - 1 / p[2]) * ... * (1 - 1 / p[n])
# n / φ(n) = (p[1] / (p[1] - 1)) * (p[2] / (p[2] - 1)) * ... * (p[n] / (p[n] - 1))
# p / (p - 1) is bigger when p is smaller

# Trying with smallest consecutive prime factors possible

num = 1
primes do |prime|
  temp = num * prime
  break if temp > 1_000_000
  num = temp
end

# Display result
puts num
