module Math
  def gcd(a, b)
    return a if b == 0
    gcd(b, a % b)
  end
end