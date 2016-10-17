defmodule MyModule do
  def check_ascii(s), do: Enum.all?(s, &(&1 >= ?A and &1 <= ?z))
end
