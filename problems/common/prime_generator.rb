class PrimeGenerator
  def initialize
    @known_primes = []
    @current_prime = 1
  end
  
  def next
    n = @current_prime
    while true do
      n += 1
      if is_prime?(n) then
        @current_prime = n
        @known_primes << @current_prime
        return @current_prime
      end
    end
  end
  
  private
  def is_prime?(n)
    max = Math.sqrt(n).to_i
    @known_primes.each do |p|
      break if p > max
      return false if n % p == 0
    end
    true
  end
end
