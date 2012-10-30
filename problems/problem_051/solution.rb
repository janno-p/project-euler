#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'common', 'primes.rb')

include Primes

pattern_hash = {}

def prime_patterns(prime)
  hash = {}
  prime.to_s.split(//).each_with_index do |char, index|
    hash[char] ||= []
    hash[char] << index
  end
  hash.each do |k, v|
    for i in 1..v.size do
      v.combination(i) do |indices|
        str = prime.to_s
        indices.each do |index|
          str[index] = '*'
        end
        yield str
      end
    end
  end
end

pattern_length = 1
Primes.primes do |prime|
  if prime.to_s.length > pattern_length then
    pattern_hash.clear
    pattern_length = prime.to_s.length
  end
  prime_patterns(prime) do |pattern|
    if pattern_hash.key?(pattern) then
      pattern_hash[pattern][0] += 1
    else
      pattern_hash[pattern] = [1, prime]
    end
    if pattern_hash[pattern][0] == 8 then
      puts pattern_hash[pattern][1]
      exit
    end
  end
end
