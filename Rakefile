task :default => [:list]

def get_problems_list
  problem_numbers = {}
  Dir.foreach('./problems/') do |name|
    if name =~ /^problem(\d+)$/ then
      problem_numbers[$1.to_i] = File.exists?(File.join('problems', name, 'solution.rb'))
    end
  end
  problem_numbers
end

desc "List all problems we have solution for"
task :list do  
  puts "Solutions for problems: #{get_problems_list.keys.sort.join(', ')}"
end

desc "Solve problem with given id"
task :solve, :problem_id do |task, args|
  problem_id = args[:problem_id]
  raise "Problem id must be given" unless problem_id
  
  problem_file_name = File.join('.', 'problems', "problem#{problem_id}", 'solution.rb')
  raise "Problem has no solution yet" unless File.exists?(problem_file_name)
  
  puts "Running solution for problem #{problem_id}..."
  require problem_file_name
end

desc "Create HTML description for problem"
task :md2html, :problem_id do |task, args|
  require 'redcarpet'
  
  problem_id = args[:problem_id]
  raise "Problem id must be given" unless problem_id
  
  problem_file_name = File.join('.', 'problems', "problem#{problem_id}", 'README.md')
  raise "Problem documentation file does not exist" unless File.exists?(problem_file_name)
  
  puts "Writing README file for problem #{problem_id}..."
  
  markdown = File.read(problem_file_name)
  processor = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  File.write('README.htm', processor.render(markdown))
end

desc "Updates main README file"
task :update do
  problem_numbers = get_problems_list
  
  content = <<-eos
# Project Euler #

My solutions for Project Euler (http://projecteuler.net) problems.

Have solutions for: #{problem_numbers.select { |k, v| v }.map { |k, v| k.to_i }.sort.join(', ') }

Solutions not completed: #{problem_numbers.select { |k, v| !v }.map { |k, v| k.to_i }.sort.join(', ') } 
eos
  
  File.write('README.md', content)
end
