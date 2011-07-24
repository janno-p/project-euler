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

class Problem69
  include Primes
  
  attr_reader :answer

  def initialize
    @prime_list = []
    primes(500_000) { |p| @prime_list << p }
  end
  
  def solve
    n, max = 1, 0
    2.upto(1_000_000) do |i|
      print '.' if i % 10_000 == 0
      puts if i % 100_000 == 0
      val = i / phi_function(i)
      n, max = i, val if val > max
    end
    @answer = n
  end

  private

  def phi_function(n)
    my_primes, temp = [], n
    @prime_list.each do |p|
      break if p > temp
      my_primes << p if temp % p == 0
      while temp % p == 0
        temp /= p
      end
    end
    x = my_primes.inject(:*)
    y = my_primes.collect { |i| i - 1 }.inject(:*)
    n / x * y
  end
end

# Very slow and not working correctly
puts Problem69.new.solve
