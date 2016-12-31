defmodule Bitmap do
  defstruct value: 0

  defimpl Enumerable do
    import :math, only: [log: 1]
    def count(%Bitmap{value: value}) do
      {:ok, trunc(log(abs(value))/log(2)) + 1}
    end
    def member?(value, bit_number) do
      {:ok, 0 <= bit_number && bit_number < Enum.count(value)}
    end
  end
end

defmodule Test do
  fifty = %Bitmap{value: 50}
  IO.puts Enum.count fifty

  IO.puts Enum.member? fifty, 4
  IO.puts Enum.member? fifty, 6
end
