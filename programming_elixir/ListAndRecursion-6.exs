defmodule MyModule do
  def flatten([]), do: []
  def flatten(head) when not is_list(head), do: head
  def flatten([head | tail]) when not is_list(head), do: [head] ++ flatten(tail)
  def flatten([head | tail]), do: flatten(head) ++ flatten(tail)
end
