#!/usr/bin/env ruby

DIM = 51

count = DIM ** 2

num_right_triangles = 0

(1...count).each do |p1|
  min = p1 + 1
  (min...count).each do |p2|
    v1x, v1y = p1 % DIM, p1 / DIM
    v2x, v2y = p2 % DIM, p2 / DIM
    v3x, v3y = v1x - v2x, v1y - v2y
    if v1x * v2x + v1y * v2y == 0 or v1x * v3x + v1y * v3y == 0 or v2x * v3x + v2y * v3y == 0 then
      num_right_triangles += 1
    end
  end
end

puts num_right_triangles
