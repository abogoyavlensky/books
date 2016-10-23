defmodule Check do
  def ok!({:ok, data}), do: data
  def ok!(param), do: raise "Error has occured with param: #{inspect(param)}"
end
