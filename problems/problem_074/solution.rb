#!/usr/bin/env ruby

factorials = (0..9).map { |n| (1..(n == 0 ? 1 : n)).inject(:*) }

sixties = 0

num_terms = []
(1...1_000_000).each do |n|
  unless num_terms[n].nil?
    sixties += 1 if num_terms[n] == 60
    next
  end
  chain = [n]
  val = n
  extra = 0
  loop do
    val = val.to_s.split(//).map { |p| factorials[p.to_i] }.inject(:+)
    unless num_terms[val].nil?
      extra = num_terms[val]
      break
    end
    break if chain.include?(val)
    chain << val
  end
  count = chain.size + extra
  while chain.size > 0
    num_terms[chain.first] = count
    count -= 1 unless chain.first == val
    chain.delete_at(0)
  end
  sixties += 1 if num_terms[n] == 60
end

puts sixties
