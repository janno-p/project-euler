# Module for various prime number methods
module Primes
  
  # Generates prime numbers.
  # If upper bound is specified with optional variable max, then generation
  # stops when that limit is reached.
  # If upper bound is not specified, then block should be exited via. break
  # statement.
  def self.primes(max = nil, &block)
    known_primes = [2]
    n = 3
    block.call(2) if block and (not max or 2 < max)
    loop do
      break if max and n > max
      if prime?(n, known_primes)
        known_primes << n        
        block.call(n) if block
      end
      n += 2
    end
    known_primes
  end
  
  # Checks if given number is prime according to known prime numbers that are
  # smaller than this particular number.
  def self.prime?(n, known_primes)
    max = Math.sqrt(n).to_i
    known_primes.each do |p|
      break if p > max
      return false if n % p == 0
    end
    true
  end
end