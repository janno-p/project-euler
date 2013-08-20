#!/usr/bin/env ruby

require 'mathn'

def enumerate_prime_combinations(num)
  return if num < 10
  dec = 10
  while dec < num do
    a = (num / dec).to_i
    b = num % dec
    if Prime.prime?(a) and Prime.prime?(b) then
      rev_dec = 10
      until a % rev_dec == a do
        rev_dec *= 10
      end
      yield a, b if Prime.prime?(b * rev_dec + a)
    end
    dec *= 10
  end
end

group = {}

Prime.each do |prime|
  break if prime > 100000
  enumerate_prime_combinations(prime) do |a, b|
    group[a] = Set.new unless group.key?(a)
    group[a] << b
    group[b] = Set.new unless group.key?(b)
    group[b] << a
    if group[a].size >= 3 or group[b].size >= 3 then
      puts "#{a},#{group[a].to_a.join(',')}" if group[a].size >= 3
      puts "#{b},#{group[b].to_a.join(',')}" if group[b].size >= 3
      exit
    end
  end
end
