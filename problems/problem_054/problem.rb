#!/usr/bin/env ruby

File.readlines(File.join(File.dirname(__FILE__), '..', 'data', 'poker.txt')).each do |line|
  puts line
end
