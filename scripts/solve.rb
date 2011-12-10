#!/usr/bin/env ruby

if ARGV.size < 1 then
  puts 'Problem number must be given'
  exit
end

problem_id = ARGV[0]
problem_dir_name = File.join('.', 'problems', "problem#{problem_id}")

unless Dir.exists?(problem_dir_name) then
  puts 'Problem directory not found'
  exit
end

problem_file_name = File.join(problem_dir_name, 'solution.rb')

unless File.exists?(problem_file_name) then
  puts 'Problem solution file not found'
  exit
end

puts 'Running solution...'

require problem_file_name
