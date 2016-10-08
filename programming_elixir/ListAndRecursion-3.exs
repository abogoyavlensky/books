defmodule MyList do
  def caesar([], _value), do: []
  def caesar([head | tail],  value) when (head + value) < 122 do
    [head + value | caesar(tail, value)]
  end
  def caesar([head | tail],  value) when (head + value) > 122 do
    [head - value | caesar(tail, value)]
  end
end
