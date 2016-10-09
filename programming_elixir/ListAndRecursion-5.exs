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
end
