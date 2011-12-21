#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'common', 'primes.rb')

include Primes

@known_primes = primes(100000)

def prime?(n)
  max = Math.sqrt(n).to_i
  @known_primes.each do |p|
    break if p > max
    return false if n % p == 0
  end
  true
end

def factorize(n)
  return { n => 1 } if prime?(n)
  factors = {}
  @known_primes.each do |prime|
    count = 0
    while n % prime == 0 do
      count += 1
      n /= prime
    end
    factors[prime] = count if count > 0
  end
  factors
end

def s(n)
  factors = factorize(n)
  # TODO : Count combinations
end

puts s(2212)
