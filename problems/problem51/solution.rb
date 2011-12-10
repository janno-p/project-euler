#!/usr/bin/env ruby

def prime?(n)
  max = Math.sqrt(n).to_i
  for i in 2..max
    return false if n % i == 0
  end
  true
end

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
