#!/usr/bin/env ruby

require 'mathn'

MAX_VALUE = 20

factors = Hash[*Prime.each(MAX_VALUE).map { |prime| [prime, 1] }.flatten]
primes = factors.keys.sort

2.upto(MAX_VALUE) do |n|
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
