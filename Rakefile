task :default => [:list]

desc "List all problems we have solution for"
task :list do
  problem_numbers = []
  Dir.foreach('./problems/') do |name|
    problem_numbers << $1.to_i if name =~ /^problem(\d+)$/
  end
  puts "Solutions for problems: #{problem_numbers.sort.join(', ')}"
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
