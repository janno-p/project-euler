#!/usr/bin/env ruby

values = {
  1 => :i,
  4 => :iv,
  5 => :v,
  9 => :ix,
  10 => :x,
  40 => :xl,
  50 => :l,
  90 => :xc,
  100 => :c,
  400 => :cd,
  500 => :d,
  900 => :cm,
  1000 => :m
}

def decode(literal, values)
  number = 0
  str = literal.downcase
  values.reverse_each do |value, roman|
    roman_number = roman.to_s
    while str.start_with?(roman_number) do
      number += value
      str = str[roman_number.length..-1]
      break if roman_number.length > 1
    end
  end
  number
end

def encode(number, values)
  literal = ""
  num = number
  values.reverse_each do |value, roman|
    roman_number = roman.to_s
    while num >= value do
      literal << roman_number
      num -= value
      break if roman_number.length > 1
    end
  end
  literal.upcase
end

reduced_sum = 0

File.readlines(File.join(File.dirname(__FILE__), '..', 'data', 'roman.txt')).each do |line|
  initial_literal = line.strip
  number = decode(initial_literal, values)
  final_literal = encode(number, values)
  
  diff = initial_literal.length - final_literal.length
  if diff < 0 then
    puts "#{number}: #{initial_literal}/#{final_literal}"
    raise "Appi!"
  end
  
  reduced_sum += diff
end

puts reduced_sum
