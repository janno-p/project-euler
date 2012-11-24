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
  values = {}
  polygonal(name) do |n, value|
    next if value < 1000 or (value / 10) % 10 == 0
    break if value > 9999
    bucket_id = value / 100
    values[bucket_id] = [] unless values.key? bucket_id
    values[bucket_id] << value
  end
  values
end

triangles = collect_values(:triangle)
squares = collect_values(:square)
pentagonals = collect_values(:pentagonal)
hexagonals = collect_values(:hexagonal)
heptagonals = collect_values(:heptagonal)
octagonals = collect_values(:octagonal)

def find_set(origin, current, groups)
  val = current % 100
  if groups.size == 0 then
    return val == origin ? [] : nil
  end
  groups.each do |g|
    next unless g.key? val
    g[val].each do |num|
      r = find_set(origin, num, groups.select { |i| i != g })
      return r.insert(0, num) unless r.nil?
    end
  end
  nil
end

octagonals.each do |k, v|
  v.each do |num|
    r = find_set(k, num, [triangles, squares, pentagonals, hexagonals, heptagonals])
    unless r.nil? then
      puts r.insert(0, num).inject(:+)
      exit
    end
  end
end
