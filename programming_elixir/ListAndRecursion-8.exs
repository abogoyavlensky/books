defmodule MyModule do
  def tax_rates, do: [ NC: 0.075, TX: 0.08 ]
  def orders, do: [[ id: 123, ship_to: :NC, net_amount: 100.00 ],
                  [ id: 124, ship_to: :OK, net_amount: 35.50 ],
                  [ id: 125, ship_to: :TX, net_amount: 24.00 ],
                  [ id: 126, ship_to: :TX, net_amount: 44.80 ],
                  [ id: 127, ship_to: :NC, net_amount: 25.00 ],
                  [ id: 128, ship_to: :MA, net_amount: 10.00 ],
                  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
                  [ id: 120, ship_to: :NC, net_amount: 50.00 ]]

  def count(taxes, orders) do
    for line = [_, {_, ship}, {_, net}] <- orders do
      if Keyword.has_key?(taxes, ship) do
        line ++ [{:total_amount,  net + taxes[ship]}]
      else
        line
      end
    end
  end

end

IO.inspect MyModule.count(MyModule.tax_rates, MyModule.orders)
