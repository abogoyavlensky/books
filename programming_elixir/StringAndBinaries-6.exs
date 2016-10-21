defmodule MyModule do
  def cap(str) when is_binary(str), do: _cap(str, :true)

  defp _cap(<<>>, _), do: <<>>
  defp _cap(<< head :: utf8, tail :: binary >>, _dot?)
  when << head >> == "."  do
    << String.upcase(<< head >>) :: binary, _cap(tail, :true) :: binary >>
  end

  defp _cap(<< head :: utf8, tail :: binary >>, dot?)
  when << head >> == " "  do
    << head, _cap(tail, dot?) :: binary >>
  end

  defp _cap(<< head :: utf8, tail :: binary >>, dot?) when dot? == :true do
    << String.upcase(<< head >>) :: binary, _cap(tail, :false) :: binary>>
  end

  defp _cap(<< head :: utf8, tail :: binary >>, _dot?) do
    << String.downcase(<< head >>) :: binary, _cap(tail, :false) :: binary >>
  end
end
