#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'common', 'primes.rb')

include Primes

# Need to find eight prime value family, so last number cannot be '*' because
# there are only 4 combinations for prime numbers: ending with 1, 3, 7 or 9.

rank, rank_max = 0, 0
result, result_score = 0, 0

def prime?(n)
  max = Math.sqrt(n).to_i
  for i in 2..max
    return false if n % i == 0
  end
  true
end

def get_mask(n, rank)
  num = n.to_s.split(//).map(&:to_i)
  a = n / 10
  r = rank - 1
  total = r ** 2
  for i in 1...total do
    x, b = 1, nil
    can_yield = for j in 0...r do
      unless i & x == 0 then
        break false if b != num[j]
        b = num[j] if b.nil?
      end
      x <<= 1
    end
    yield i.to_s(2).to_i if can_yield
  end
end

primes do |number|
  while number > rank_max do
    rank += 1
    rank_max = 10 ** rank
    puts "Rank: #{rank}; Max: #{rank_max}; Number: #{number}"
  end
  next unless rank > 1
  if rank == 2 then
    z, count = (number + 10), 1
    while z < rank_max do
      count += 1 if prime?(z)
      z += 10
    end
    if count > result_score then
      result = number
      result_score = count
    end
  else
    break
  end
end

puts "#{result}/#{result_score}"

exit

primes(100) do |prime|
  next if prime < 10
  
end


primes(1_000_000) do |p|
  puts p
end

exit



def create_masks(rank)
  masks = []
  for i in 1...(rank**2 - 1)
    
  end
  masks
end

1..15

def mask(n, rank)
  if rank == 1
    yield n[0]
    yield "*"
  else
    mask(n, rank - 1) do |sub_mask|
      yield "#{sub_mask}#{n[rank - 1]}"
      yield "#{sub_mask}*"
    end
  end
end

min = 1
max = 9

rank = 1
rank.times do
  min = min * 10
  max = max * 10 + 9
end

puts "#{min}-#{max}"

prime_groupes = Array.new(rank**2 - 1) { 0 }
for i in min..max
  next if i % 2 == 0
  next unless prime?(i)
  puts i
end
