#!/usr/bin/env ruby

class Array
  def values
    known.collect { |item| item.value }
  end
  
  def unknown
    select { |e| e.is_a?(Item) and !e.known? }
  end
  
  def known
    select { |e| e.is_a?(Item) and e.known? }
  end
end

class Item
  attr_reader :value, :possible, :box, :column, :row
  
  def initialize(value, box, column, row)
    @value = (value == 0 ? nil : value)
    @possible = (1..9).to_a
    @box = box << self
    @column = column << self
    @row = row << self
  end
  
  def known?
    !@value.nil?
  end
  
  def update_single
    @possible -= (@box.values + @column.values + @row.values)
    if @possible.size == 1
      @value = @possible[0]
      @possible.clear
      @box.unknown.each { |item| item.possible.delete(@value) }
      @column.unknown.each { |item| item.possible.delete(@value) }
      @row.unknown.each { |item| item.possible.delete(@value) }
    end
    known?
  end
  
  def update_exclude
    check_for_single_possible_value(@box) or
    check_for_single_possible_value(@column) or
    check_for_single_possible_value(@row)
  end
  
  def check_for_single_possible_value(list)
    @possible.each do |v|
      if list.unknown.select { |e| e != self and e.possible.include?(v) }.size == 0
        @possible.delete_if { |val| val != v }
        return true
      end
    end
    false
  end
end

class Grid
  def self.from_file(file)
    name = file.gets
    return nil unless name
    name.strip
    matrix = 9.times.inject([]) { |m, i| m += file.gets.strip.split(//).collect { |n| n.to_i } }
    Grid.new(name, matrix)
  end
  
  def initialize(name, matrix)
    @name = name
    @boxes = 9.times.collect { [] }
    @columns = 9.times.collect { [] }
    @rows = 9.times.collect { [] }
    @unknown_items = []
    parse(matrix)
  end
  
  def solve
    loop do
      has_changed = false
      while update_unknown { |item| item.update_single }
        has_changed = true
      end
      if update_exclude
        has_changed = true
      end
      break unless has_changed
    end
    @unknown_items.empty?
  rescue Exception => e
    puts e
    false
  ensure
    print
  end
  
  def print
    puts @name
    @rows.each { |row| puts row.collect { |item| item.value || '_' }.join(',') }
  end
  
private
  
  def parse(matrix)
    matrix.each_with_index do |value, index|
      item = Item.new(
        value,
        @boxes[3 * ((index / 9) / 3) + ((index % 9) / 3)],
        @columns[index % 9],
        @rows[index / 9])
      @unknown_items << item unless item.known?
    end
  end
  
  def update_unknown
    known_items = @unknown_items.select { |item| yield item }
    @unknown_items -= known_items
    known_items.any?
  end
  
  def update_exclude
    has_changed = false
    @unknown_items.each do |item|
      has_changed = true if item.update_exclude
    end
    has_changed
  end
end

File.open(File.join(File.dirname(__FILE__), '..', 'data', 'sudoku.txt'), 'r') do |file|
  failed_count = 0
  while (solver = Grid.from_file(file))
    failed_count += 1 unless solver.solve
    puts
  end
  puts "Failed solutions: #{failed_count}"
end

