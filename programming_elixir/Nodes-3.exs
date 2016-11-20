defmodule Ticker do
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(pid) do
    send :global.whereis_name(@name), {:register, pid}
  end

  def generator(clients) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        generator([pid | clients])
      after @interval ->
        IO.puts "tick"
        clients
        |> Enum.reverse
        |> Enum.with_index
        |> Enum.each(fn({x, i})-> send(x, {:tick, i}) end)
        generator(clients)
    end
  end
end

defmodule Client do
  def start do
    __MODULE__
    |> spawn(:receiver, [])
    |> Ticker.register
  end

  def receiver do
    receive do
      {:tick, index} ->
        IO.puts "tock in client #{inspect index}"
        receiver
    end
  end
end
