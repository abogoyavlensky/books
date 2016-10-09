defmodule MyList do
  def span(from, to), do: _span([from | []], to)

  defp _span([head | tail], to) when head == to, do: [head | tail]
  defp _span([head | tail], to), do: [head | _span([head + 1 | tail], to)]
end
