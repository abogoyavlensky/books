defmodule Sum do
  def all(0), do: 0
  def all(n), do: n + all(n - 1)
end
