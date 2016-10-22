defmodule Taxes do
  def get_taxes(file_name \\ "taxes.txt") do
    list = File.open!(file_name)
            |> IO.stream(:line)
            |> Enum.map(&parse/1)
            |> Enum.filter(&(&1 != :nil))
  end

  def parse(str), do: String.split(str, ",") |> _parse_line

  def _parse_line([id, to, net]) do
  # when is_integer(<< id :: integer>>) and is_atom(<< to :: binary>>) and is_float(<< net :: float>>) do
    # [id: String.to_integer(id), ship_to: to, net_amount: net]
    [id: Integer.parse(id) |> _first,
     ship_to: String.trim(to, ":") |> _to_atom |> _first,
     net_amount: Float.parse(net) |> _first]
  end
  def _parse_line([_, _, _]), do: :nil

  defp _first(resp) when resp == :error, do: :error
  defp _first({value, _}), do: value

  defp _to_atom(n) when is_binary(n), do: {String.to_atom(n), ""}


  # def tax_rates, do: [ NC: 0.075, TX: 0.08 ]
  # def orders, do: [[ id: 123, ship_to: :NC, net_amount: 100.00 ],
  #                 [ id: 124, ship_to: :OK, net_amount: 35.50 ],
  #                 [ id: 125, ship_to: :TX, net_amount: 24.00 ],
  #                 [ id: 126, ship_to: :TX, net_amount: 44.80 ],
  #                 [ id: 127, ship_to: :NC, net_amount: 25.00 ],
  #                 [ id: 128, ship_to: :MA, net_amount: 10.00 ],
  #                 [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  #                 [ id: 120, ship_to: :NC, net_amount: 50.00 ]]

  # def count(taxes, orders) do
  #   for line = [_, {_, ship}, {_, net}] <- orders do
  #     if Keyword.has_key?(taxes, ship) do
  #       line ++ [{:total_amount,  net + taxes[ship]}]
  #     else
  #       line
  #     end
  #   end
  # end
end
