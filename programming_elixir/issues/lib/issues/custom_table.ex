defmodule Issues.CustomTable do
  @moduledoc """
  Print table os issues from list of column names.
  """

  @vertical " | "
  @corner "-+-"
  @line "-"

  def print_table(list, columns) do
    columns
    |> Enum.map(&max_by_item(list, &1))
    |> Enum.zip(columns)
    |> Enum.map(&make_header_struct/1)
    |> _print_table(list)
  end

  defp max_by_item(list, name) when is_binary(name) and is_list(list) do
    list
    |> _get_list_to_check_length(name)
    |> Enum.map(&(&1[name]))
    |> Enum.max_by(&_length/1)
    |> _length
  end
  defp _length(v) when is_binary(v), do: String.length(v)
  defp _length(v) when is_integer(v), do: v |> Integer.to_string |> _length

  defp make_header_struct({count, name}), do: %{name: name, count: count}

  defp _print_table(header, list) do
    header
    |> _collect_table(list)
    |> Enum.each(&IO.puts/1)
  end

  defp _collect_table(header, list) do
    [:header | [:line | list]]
    |> Enum.map(&_collect_row(&1, header))
  end

  defp _collect_row(:header, header) do
    header
    |> Enum.map_join(@vertical, &_collect_cell/1)
  end
  defp _collect_row(:line, header) do
    header
    |> Enum.map_join(@corner, &_collect_cell(%{name: String.duplicate(@line, &1[:count]),
                                 count: &1[:count]}))
  end
  defp _collect_row(issue, header) do
    header
    |> Enum.map_join(@vertical,
                     &_collect_cell(%{name: _to_string(issue[&1[:name]]),
                                      count: &1[:count]}))
  end

  defp _collect_cell(%{name: name, count: count}) do
    name
    |> _format_title
    |> _get_cell(count)
  end

  defp _get_cell(word, count) do
    word |> String.ljust(count)
  end

  defp _to_string(val) when is_integer(val), do: val |> Integer.to_string
  defp _to_string(val) when is_binary(val) , do: val

  @doc """
  Return sign "#" instead of "number" string or return the value themselvs.
  
  ## Examples
  
      iex> Issues.CustomTable._format_title("number")
      "#"

      iex> Issues.CustomTable._format_title("word")
      "word"
  """
  def _format_title("number"), do: "#"
  def _format_title(name), do: name

  defp _get_list_to_check_length(list, "number"), do: list
  defp _get_list_to_check_length(list, name), do: list ++ [%{name => name}]
end
