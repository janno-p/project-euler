require File.join(File.dirname(__FILE__), 'math.rb')

class Fraction
  include Math
  
  attr_reader :numerator, :denominator
  
  def initialize(numerator, denominator = 1)
    numerator / denominator
    @numerator = numerator
    @denominator = denominator
    simplify
  end
  
  def <(fraction)
    @numerator * fraction.denominator < fraction.numerator * @denominator
  end
  
  def >(fraction)
    @numerator * fraction.denominator > fraction.numerator * @denominator
  end
  
  def +(fraction)
    Fraction.new(@numerator * fraction.denominator + fraction.numerator * @denominator, @denominator * fraction.denominator)
  end
  
  def -(fraction)
    Fraction.new(@numerator * fraction.denominator - fraction.numerator * @denominator, @denominator * fraction.denominator)
  end
  
  def *(fraction)
    Fraction.new(@numerator * fraction.numerator, @denominator * fraction.denominator)
  end
  
  def /(fraction)
    Fraction.new(@numerator * fraction.denominator, fraction.numerator * @denominator)
  end
  
  def to_f
    @numerator.to_f / @denominator
  end
  
  def to_s
    return "0" if @numerator == 0
    return @numerator.to_s if @denominator == 1
    "#{@numerator}/#{@denominator}"
  end
  
  private
  
  def simplify
    d = gcd(@numerator, @denominator)
    @numerator = (@numerator / d).to_i
    @denominator = (@denominator / d).to_i
  end
  
  public
  
  Zero = Fraction.new(0, 1)
end
