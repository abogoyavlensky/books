defmodule Taxes do
  def orders(file_name \\ "taxes.txt") do
    list = File.open!(file_name)
            |> IO.stream(:line)
            |> Enum.map(&(String.split(&1, ",") |> _parse_line))
            |> Enum.filter(&_filter_error/1)
  end

  def _parse_line([id, to, net]) do
    [id: Integer.parse(id) |> _first,
     ship_to: String.trim(to, ":") |> _to_atom |> _first,
     net_amount: Float.parse(net) |> _first]
  end

  defp _first({value, _}), do: value
  defp _first(resp), do: :error

  defp _to_atom(n) when is_binary(n), do: {String.to_atom(n), ""}

  defp _filter_error(line), do: Enum.all?(Keyword.values(line), &(&1 != :error))

  def rates, do: [ NC: 0.075, TX: 0.08 ]

  def count(orders, rates) do
    for line = [_, {_, ship}, {_, net}] <- orders do
      if Keyword.has_key?(rates, ship) do
        line ++ [{:total_amount,  Float.round(net + rates[ship], 2)}]
      else
        line
      end
    end
  end
end

# Taxes.count(Taxes.orders, Taxes.rates)
