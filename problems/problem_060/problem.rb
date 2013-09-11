#!/usr/bin/env ruby

require 'mathn'
require 'set'

def concat(a, b)
  dec = 10
  until b % dec == b do
    dec *= 10
  end
  return a * dec + b
end

def enumerate_prime_combinations(num)
  return if num < 10
  dec = 10
  while dec < num do
    a = (num / dec).to_i
    b = num % dec
    if Prime.prime?(a) and Prime.prime?(b) then
      yield a, b if Prime.prime?(concat(b, a))
    end
    dec *= 10
  end
end

group2 = {}
group3 = {}
group4 = {}

Prime.each do |prime|
  break if prime > 100000
  enumerate_prime_combinations(prime) do |a, b|
    group2[a] ||= Set.new
    group2[a] << b
    group2[b] ||= Set.new
    group2[b] << a
    (group2[a] & group2[b]).each do |n|
      group3[a] ||= Set.new
      group3[a] += [b, n]
      group3[b] ||= Set.new
      group3[b] += [a, n]
      group3[n] ||= Set.new
      group3[n] += [a, b]
      (group3[a] & group3[b] & group3[n]).each do |m|
        group4[a] ||= Set.new
        group4[a] += [b, n, m]
        group4[b] ||= Set.new
        group4[b] += [a, n, m]
        group4[n] ||= Set.new
        group4[n] += [a, b, m]
        group4[m] ||= Set.new
        group4[m] += [a, b, n]
      end
    end
  end
end

puts group4
