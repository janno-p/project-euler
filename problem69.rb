#!/usr/bin/env ruby

# # Problem 69 #
#
# Euler's Totient function, φ(n) [sometimes called the phi function], is used to
# determine the number of numbers less than n which are relatively prime to n.
# For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively
# prime to nine, φ(9)=6.
#
#    n  Relatively Prime  φ(n)  n/φ(n)
#    2  1                 1     2
#    3  1,2               2     1.5
#    4  1,3               2     2
#    5  1,2,3,4           4     1.25
#    6  1,5               2     3
#    7  1,2,3,4,5,6       6     1.1666...
#    8  1,3,5,7           4     2
#    9  1,2,4,5,7,8       6     1.5
#   10  1,3,7,9           4     2.5
#
# It can be seen that n=6 produces a maximum n/φ(n) for n  10.
#
# Find the value of n  1,000,000 for which n/φ(n) is a maximum.

require './primes'

include Primes

# pi is prime factor of the number
# φ(n) = n * (1 - 1 / p1) * (1 - 1 / p2) * ... * (1 - 1 / pn)
# n / φ(n) = (p1 / (p1 - 1)) * (p2 / (p2 - 1)) * ... * (pn / (pn - 1))
# p / (p - 1) is bigger when p is smaller

# Trying with smallest consecutive prime factors possible

num = 1
primes do |prime|
  temp = num * prime
  break if temp > 1_000_000
  num = temp
end

puts num
