#!/usr/bin/env ruby

matches = []
for i in 1...10000 do
  for j in 1...10000 do
    k = i * j
    next if i.to_s.include?('0') or j.to_s.include?('0') or k.to_s.include?('0')
    length = i.to_s.length + j.to_s.length + k.to_s.length
    break if length > 9
    next unless length == 9
    digits = []
    i.to_s.each_char { |c| digits << c }
    j.to_s.each_char { |c| digits << c }
    k.to_s.each_char { |c| digits << c }
    matches << k if digits.uniq.size == 9 and !matches.include?(k)
  end
end

puts matches.inject(:+)
