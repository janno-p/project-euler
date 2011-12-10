# Module for various prime number methods
module Primes
  
  # Generates prime numbers.
  # If upper bound is specified with optional variable max, then generation
  # stops when that limit is reached.
  # If upper bound is not specified, then block should be exited via. break
  # statement.
  def primes(max = nil)
    known_primes = []
    n = 2
    loop do
      return if max and n > max
      if is_prime?(n, known_primes)
        known_primes << n
        yield n
      end
      n += 1
    end
  end
  
  # Checks if given number is prime according to known prime numbers that are
  # smaller than this particular number.
  def is_prime?(n, known_primes)
    max = Math.sqrt(n).to_i
    known_primes.each do |p|
      break if p > max
      return false if n % p == 0
    end
    true
  end
end