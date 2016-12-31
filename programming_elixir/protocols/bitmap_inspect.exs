defmodule Bitmap do
  defstruct value: 0

  defimpl Inspect do
    def inspect(%Bitmap{value: value}, _opts) do
      "%Bitmap{#{value}=#{as_binary(value)}}"
    end
    defp as_binary(value) do
      to_string(:io_lib.format("~.2B", [value]))
    end
  end
end


defmodule Test do
  fifty = %Bitmap{value: 50}

  IO.inspect fifty
  IO.inspect fifty, structs: false
end
