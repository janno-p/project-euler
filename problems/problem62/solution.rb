#!/usr/bin/env ruby

number_hash = {}

n = 1
loop do
  key = (n ** 3).to_s.split(//).sort
  if number_hash.key?(key) then
    number_hash[key][0] += 1
  else
    number_hash[key] = [1, n]
  end
  if number_hash[key][0] == 5 then
    puts number_hash[key][1] ** 3
    break
  end
  n += 1
end
