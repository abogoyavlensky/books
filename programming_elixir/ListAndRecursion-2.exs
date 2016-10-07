defmodule MyModule do
  def max(list), do: _max(list, 0)

  defp _max([], value), do: value
  defp _max([head | tail], value) when head >= value, do: _max(tail, head)
  defp _max([head | tail], value) when head < value, do: _max(tail, value)
end
