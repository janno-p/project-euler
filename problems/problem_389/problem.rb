#!/usr/bin/env ruby

table = Array.new(24) { 0 }

class Roller
  attr_reader :min, :max, :list

  def initialize(count, range)
    @count = count
    @range = range
    @min = @count * @range.min
    @max = @count * @range.max
    @list = Array.new(@count * @range.count)
    iterate(@count - 1) { |i| @list[i] = (@list[i] || 0) + 1 }
    #@list.each_with_index { |c, i| puts "#{i}: #{c}" }
  end

  def iterate(depth)
    if depth == 0 then
      @range.each { |i| yield i }
    else
      @range.each do |i|
        iterate(depth - 1) do |j|
          yield i + j
        end
      end
    end
  end
end

r4 = Roller.new(1, 1..4)
for t in r4.min..r4.max do
  r6 = Roller.new(t, 1..6)
  for c in r6.min..r6.max do
    r8 = Roller.new(c, 1..8)
  end
end

r8.each_with_index do |c, i|
  print "#{i}: #{c}, "
end
puts
