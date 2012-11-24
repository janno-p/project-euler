#!/usr/bin/env ruby

def gcd(a, b)
  return a if b == 0
  gcd(b, a % b)
end

count = 0
limit = 12000

for n in 1..(limit / 2) do
  low = [2 * n + 1, limit].min
  high = [3 * n - 1, limit].min
  for d in low..high do
    next if n > 1 and gcd(n,d) != 1
    count += 1
  end
end

puts count
