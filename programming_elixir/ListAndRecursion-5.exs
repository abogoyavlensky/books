defmodule MyEnum do
  def all?(list, fun \\ fn x -> x end)
  def all?([], _fun), do: True
  def all?([head | tail], fun) do
    if fun.(head) in [nil, false] do
      False
    else
      all?(tail, fun)
    end
  end

  def each([], _fun), do: :ok
  def each([head | tail], fun) do
    fun.(head)
    each(tail, fun)
  end

  def filter([], _fun), do: []
  def filter([head | tail], fun) do
    if fun.(head) do
      [head | filter(tail, fun)]
    else
      filter(tail, fun)
    end
  end

  def split(list, count) when count > 0, do: _split({[], list}, count)
  def split(list, count) do
     num = _len(list) + count
     if num >= 0 do
       _split({[], list}, num)
     else
       {[], list}
     end
   end

  defp _split(result = {_left , []}, _count), do: result
  defp _split(result = {_left , _right}, count) when count == 0, do: result
  defp _split({left, right}, count) when count != 0 do
    [head | tail] = right
    _split({left ++ [head], tail}, count - 1)
  end

  defp _len([]), do: 0
  defp _len([_head | tail]), do: 1 + _len(tail)
end
