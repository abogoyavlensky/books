defmodule MyMap do
  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def reduce([], initial_value, _func), do: initial_value
  def reduce([head | tail], initial_value, func) do
    reduce(tail, func.(head, initial_value), func)
  end

  def mapsum(list, func), do: _mapsum(list, 0, func)

  defp _mapsum([], value, _func), do: value
  defp _mapsum([head | tail], value, func), do: _mapsum(tail, func.(head) + value, func)
end
