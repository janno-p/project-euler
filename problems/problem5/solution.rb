#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'common', 'primes.rb')

MaxValue = 20

factors = Hash[*Primes::primes(MaxValue).map { |i| [i, 1] }.flatten]
primes = factors.keys.sort

2.upto(MaxValue) do |n|
  primes.each do |p|
    break if n == 1
    count = 0
    while n % p == 0 do
      count += 1
      n /= p
    end
    factors[p] = count if factors[p] < count
  end
end

puts factors.inject(1) { |num, f| num *= (f[0] ** f[1]) }
