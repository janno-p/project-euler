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
  require 'builder'
  
  row_length = 15
  problem_count = 363
  problem_numbers = get_problems_list
  num_rows = problem_count / row_length + 1
  
  builder = Builder::XmlMarkup.new
  table_html = builder.table do
    num_rows.times do |row|
      builder.tr do
        row_length.times do |column|
          number = row * row_length + column + 1
          number = '' if number > problem_count
          builder.td do
            if problem_numbers.key?(number) then
              builder.strong { problem_numbers[number] ? builder.del(number.to_s) : builder.ins(number.to_s) }
            else
              builder.strong(number.to_s)
            end
          end
        end
      end
    end
  end
  
  content = <<-eos
# Project Euler #

My solutions for Project Euler (http://projecteuler.net) problems.

#{table_html}
eos
  
  File.write('README.md', content)
end
