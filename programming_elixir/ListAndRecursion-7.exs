defmodule MyModule do
  def get_primes(from, to) do
    for x <- span(from, to), prime?(x), do: x
  end

  def span(from, to), do: _span([from | []], to)

  defp _span([head | tail], to) when head == to, do: [head | tail]
  defp _span([head | tail], to), do: [head | _span([head + 1 | tail], to)]

  def prime?(n), do: _smallest_div(n) == n

  defp _smallest_div(n), do: _find_div(n, 2)

  defp _find_div(n, test_div) when (test_div * test_div) > n, do: n
  defp _find_div(n, test_div) when rem(n, test_div) == 0, do: test_div
  defp _find_div(n, test_div), do: _find_div(n, test_div + 1)
end
