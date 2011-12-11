#!/usr/bin/env ruby

require 'redcarpet'

puts 'Input file name must be given' if ARGV.size < 1

input_file = ARGV[0]

unless File.exists?(input_file)
  puts 'Input file does not exist'
  exit
end

output_file = 'test.htm'
output_file = ARGV[1] if ARGV.size > 1

markdown = File.read(input_file)
processor = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
File.write(output_file, processor.render(markdown))