defmodule LineSigil do
  def sigil_v(lines, _opts) do
    lines
    |> String.rstrip
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
  end
end


defmodule Example do
  import LineSigil

  def values do
    ~v"""
    1,2,3
    cat,dog
    """
  end
end


IO.inspect Example.values
