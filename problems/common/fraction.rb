require File.join(File.dirname(__FILE__), 'math.rb')

class Fraction
  attr_reader :numerator, :denominator
  
  def initialize(numerator, denominator)
    @numerator = numerator
    @denominator = denominator
    simplify
  end
  
  def to_f
    @numerator.to_f / @denominator
  end
  
  private
  def simplify
    d = Math::gcd(@numerator, @denominator)
    @numerator /= d
    @denominator /= d
  end
end
