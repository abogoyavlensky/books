defmodule Chop do
  def guess(actual, bottom..top) do
    helper(actual, bottom..top, div(top, 2))
  end

  def helper(actual, bottom..top, current) when actual > current do
    IO.puts("Is it #{current}")
    helper(actual, current..top, current + div(top - current, 2))
  end

  def helper(actual, bottom..top, current) when actual < current do
    IO.puts("Is it #{current}")
    helper(actual, bottom..current, bottom + div(current - bottom, 2))
  end

  def helper(actual, bottom..top, current) when actual == current do
    IO.puts("Is it #{current}")
    IO.puts("#{current}")
  end
end
