#!/usr/bin/env ruby

@polygonals = {
  :triangle => lambda { |n| n * (n + 1) / 2 },
  :square => lambda { |n| n ** 2 },
  :pentagonal => lambda { |n| n * (3 * n - 1) / 2 },
  :hexagonal => lambda { |n| n * (2 * n - 1) },
  :heptagonal => lambda { |n| n * (5 * n - 3) / 2 },
  :octagonal => lambda { |n| n * (3 * n - 2) },
}

def polygonal(name)
  formula = @polygonals[name]
  n = 0
  loop do
    n += 1
    yield n, formula.call(n)
  end
end

def collect_values(name)
  values = []
  polygonal(name) do |n, value|
    next if value < 1000 or (value / 10) % 10 == 0
    break if value > 9999
    values << value
  end
  values
end

triangles = collect_values(:triangle)
squares = collect_values(:square)
pentagonals = collect_values(:pentagonal)
hexagonals = collect_values(:hexagonal)
heptagonals = collect_values(:heptagonal)
octagonals = collect_values(:octagonal)

puts triangles.count
puts squares.count
puts pentagonals.count
puts hexagonals.count
puts heptagonals.count
puts octagonals.count
