defmodule MyModule do
  def calculate(str), do: _parse(str)

  defp _parse(str, left \\ 0, rigth \\ 0, sign \\ :nil)

  defp _parse([], _, _, :nil), do: :nil
  defp _parse([], left, right, sign), do: _apply(sign, left, right)

  defp _parse([head | tail], left, right, :nil)
  when head in '0123456789' do
      _parse(tail, _add_char(left, head), right)
  end
  defp _parse([head | tail], left, right, sign)
  when head in '0123456789'do
      _parse(tail, left, _add_char(right, head), sign)
  end
  defp _parse([head | tail], left, right, :nil)
  when head in '+-*/' do
    _parse(tail, left, right, head)
  end
  defp _parse([?\s | tail], left, right, sign) do
    _parse(tail, left, right, sign)
  end
  defp _parse([head | _], _, _, _) do
    raise "Invalid digit '#{[head]}'"
  end

  defp _add_char(value, char), do: (value * 10) + (char - ?0)

  defp _apply(?+, left, right), do: left + right
  defp _apply(?-, left, right), do: left - right
  defp _apply(?*, left, right), do: left * right
  defp _apply(?/, left, right), do: left / right
end
