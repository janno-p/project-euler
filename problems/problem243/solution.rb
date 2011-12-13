#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'common', 'math.rb')

include Math

def count_resilient_fractions(n)
  count = 0
  1.step(n - 1, n % 2 == 0 ? 2 : 1)
  for i in 1...n do
    count += 1 if gcd(i, n) == 1
  end
  count
end

def required_resilience?(d)
  n = count_resilient_fractions(d)
  94744 * n < 15499 * (d - 1)
end

d = 2
until required_resilience?(d)
  puts d if d % 1000 == 0
  d += 1
end

puts d
