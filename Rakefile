require 'colorize'
require 'open3'

task :default => [:list]

def collect_problems
  Dir.foreach('problems').map do |name|
    [$1.to_i, File.exists?(File.join('problems', name, 'solution.rb'))] if name =~ /^problem_(\d{3})$/
  end.compact
end

def get_completed
  collect_problems.map { |item| item.first if item.last }.compact.sort
end

def get_uncompleted
  collect_problems.map { |item| item.first unless item.last }.compact.sort
end

def problem_path(problem_id, file_name = nil)
  return File.join('.', 'problems', 'problem_%03d' % problem_id, file_name || '')
end

def run_file(file_name, color)
  Open3.popen3("ruby #{file_name}") do |stdin, stdout, stderr|
    begin
      while line = stdout.readline
        line = line.send(color) if color
        print line
      end
    rescue
    ensure
      puts
    end
  end
end

desc "List all problems we have solution for"
task :list do
  puts "Problems with solution: #{get_completed.join(', ')}".green
  puts "Problems uncompleted: #{get_uncompleted.join(', ')}".yellow
end

desc "Run problem with given id"
task :run, :problem_id do |task, args|
  problem_id = args[:problem_id]
  raise "Problem id must be given".red unless problem_id

  file_name = problem_path(problem_id, 'solution.rb')
  if File.exists?(file_name) then
    puts "Running solution for problem #{problem_id}...".blue
    run_file(file_name, :green)
    exit
  end

  file_name = problem_path(problem_id, 'problem.rb')
  if File.exists?(file_name) then
    puts "Testing solution for problem #{problem_id}...".blue
    run_file(file_name, :yellow)
    exit
  end

  raise "Problem has no solution yet".red
end

desc "Create HTML description for problem"
task :md2html, :problem_id do |task, args|
  require 'redcarpet'

  problem_id = args[:problem_id]
  raise "Problem id must be given".red unless problem_id

  problem_file_name = problem_path(problem_id, 'README.md')
  raise "Problem documentation file does not exist".red unless File.exists?(problem_file_name)

  puts "Writing README file for problem #{problem_id}...".blue

  markdown = File.read(problem_file_name)
  processor = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  File.write('README.htm', processor.render(markdown))
end

desc "Updates main README file"
task :update do
  puts "Writing main README file...".blue
  File.open('README.md', 'w') do |file|
    file.write(<<-eos)
# Project Euler #

My solutions for Project Euler (http://projecteuler.net) problems.

Have solutions for: #{get_completed.join(', ') }

Solutions not completed: #{get_uncompleted.join(', ') }
eos
  end
end
