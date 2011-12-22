task :default => [:list]

def collect_problems
  Dir.foreach('problems').map do |name|
    [$1.to_i, File.exists?(File.join('problems', name, 'solution.rb'))] if name =~ /^problem(\d+)$/
  end.compact
end

def get_completed
  collect_problems.map { |item| item.first if item.last }.compact.sort
end

def get_uncompleted
  collect_problems.map { |item| item.first unless item.last }.compact.sort
end

desc "List all problems we have solution for"
task :list do  
  puts "Solutions for problems: #{get_completed.join(', ')}"
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
  File.write('README.md', <<-eos)
# Project Euler #

My solutions for Project Euler (http://projecteuler.net) problems.

Have solutions for: #{get_completed.join(', ') }

Solutions not completed: #{get_uncompleted.join(', ') } 
eos
end
