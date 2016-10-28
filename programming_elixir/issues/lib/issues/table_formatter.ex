defmodule Issues.TableFormatter do
  @moduledoc """
  Print formating table of issues from book example.
  """

  import Enum, only: [each: 2, map: 2, map_join: 3, max: 1]

  def print_table(rows, headers) do
    # data_by_columns =
  end

  def split_into_columns(rows, headers) do
    for header <- headers do
      for row <- rows, do: printable(row[header])
    end
  end

  def printable(str) when is_binary(str) , do: str
  def printable(str), do: to_string(str)

  def widths_of_columns(columns) do
    for column <- columns, do: column |> map(&String.length/1) |> max
  end

  def format_for(column_widths) do
    map_join(column_widths, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  def separator(column_widths) do
    map_join(column_widths, "-+-", fn width -> List.duplicate("-",width) end)
  end
end
