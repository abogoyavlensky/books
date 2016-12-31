defmodule LineSigil do
  def sigil_v(lines, _opts) do
    lines
    |> String.rstrip
    |> String.split("\n")
    |> Enum.map(&convert/1)
  end

  defp convert(str) do
    str
    |> String.split(",")
    |> Enum.map(&parse/1)
  end

  defp parse(value) do
    case Float.parse(value) do
      :error -> value
      {number, _} -> number
    end
  end
end


defmodule Example do
  import LineSigil

  def values do
    ~v"""
    1,2,3.14
    cat,dog
    """
  end
end


IO.inspect Example.values
