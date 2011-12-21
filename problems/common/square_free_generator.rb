require File.join(File.dirname(__FILE__), 'prime_generator.rb')

class SquareFreeGenerator
  def initialize
    @generator = PrimeGenerator.new
    @max_prime = 0
    @known_square_free = []
    @known_primes = []
    @current = 0
  end
  
  def next
    n = @current + 1
    until square_free?(n) do
      n += 1
    end
    @known_square_free << n
    @current = n
  end
  
  def square_free?(n)
    max = Math.sqrt(n).to_i
    while @max_prime < max do
      @max_prime = @generator.next
      @known_primes << @max_prime
    end
    @known_primes.each do |prime|
      break if max < prime
      prime_square = prime ** 2
      return false if n % prime_square == 0
    end
    true
  end
end
