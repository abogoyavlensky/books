defmodule Alg do
  def gcd(x, 0), do: x
  def gcd(x, y), do: rem(x, y)
end
