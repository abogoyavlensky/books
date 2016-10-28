defmodule Issues.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """

  @default_count 4
  @vertical " | "
  @corner "-+-"
  @line "-"


  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  'argv' can be -h or --help, which returns :help.
  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.
  Return a tuple of '{ user, project, count }', or ':help' if help was given.
  """
  def parse_args(argv) do
      parse = OptionParser.parse(argv, switched: [help: :boolean],
                                       aliases: [h: :help])
      case parse do
        {[help: true], _, _} -> :help
        {_, [user, project, count], _}
        -> {user, project, String.to_integer(count)}
        {_, [user, project], _} -> {user, project, @default_count}
        _ -> :help
      end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [coun | #{@default_count}]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    user
    |> Issues.GithubIssues.fetch(project)
    |> decode_response
    |> convert_to_list_of_maps
    |> sort_into_ascending_order
    |> Enum.take(count)
    |> print_table_for_columns(["number", "created_at", "title"])
  end

  def decode_response({:ok, body}) do
      body
  end
  def decode_response({:error, reason}) do
    {_, message} = List.keyfind(reason, "message", 0)
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end

  def convert_to_list_of_maps(list) do
    list |> Enum.map(&Enum.into(&1, Map.new))
  end

  def sort_into_ascending_order(list_of_issues) do
    Enum.sort(list_of_issues, &(&1["created_at"] <= &2["created_at"]))
  end

  def print_table_for_columns(list, columns) do
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
    |> Enum.map(&_collect_cell/1)
    |> Enum.join
  end
  defp _collect_row(:line, header) do
    header
    |> Enum.map(&_collect_cell(%{name: String.duplicate(@line, &1[:count]),
                                 count: &1[:count]},
                                @corner))
    |> Enum.join
  end
  defp _collect_row(issue, header) do
    header
    |> Enum.map(&_collect_cell(%{name: _to_string(issue[&1[:name]]),
                                 count: &1[:count]}))
    |> Enum.join
  end

  defp _collect_cell(%{name: name, count: count}, delimiter \\ @vertical) do
    name
    |> _format_title
    |> _get_cell(count)
    |> _join_delimiter(delimiter)
  end

  defp _get_cell(word, count) do
    word |> String.ljust(count)
  end

  defp _to_string(val) when is_integer(val), do: val |> Integer.to_string
  defp _to_string(val) when is_binary(val) , do: val

  defp _join_delimiter(word, delimiter), do: word <> delimiter

  defp _format_title("number"), do: "#"
  defp _format_title(name), do: name

  defp _get_list_to_check_length(list, "number"), do: list
  defp _get_list_to_check_length(list, name), do: list ++ [%{name => name}]
end
