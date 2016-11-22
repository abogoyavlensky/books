defmodule Stack do
  use GenServer

  def handle_call(:pop, _from, state) do
    [head | tail] = state
    {:reply, head, tail}
  end
end
