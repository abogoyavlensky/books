defmodule LineSigil do
  def sigil_l(lines, _opts) do
    lines |> String.rstrip |> String.split("\n")
  end
end


# defmodule Example do
#   import LineSigil
#
#   def lines do
#     ~l"""
#     line 1
#     line 2
#     and another line in module #{__MODULE__}
#     """
#   end
# end
#
#
# IO.inspect Example.lines
