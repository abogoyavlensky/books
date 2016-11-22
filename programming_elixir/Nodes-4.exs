defmodule Ticker do
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :registrator, [:nil, :nil])
    :global.register_name(@name, pid)
  end

  def register(pid) do
    send :global.whereis_name(@name) , {:register, pid}
  end

  def registrator(head, tail) do
    receive do
      {:register, pid} when head == :nil and tail == :nil ->
        send pid, {:next, pid}
        IO.puts "Registered new head #{inspect pid}"
        IO.puts "Registered new tail #{inspect pid}"
        send pid, {:tick, self}
        IO.puts "Started tick!"
        registrator(pid, pid)
      {:register, pid} ->
        send pid, {:next, head}
        send tail, {:next, pid}
        IO.puts "Registered new tail #{inspect pid}"
        IO.puts "Linked new tail #{inspect pid} to head #{inspect head}"
        registrator(head, pid)
    end
  end
end

defmodule Client do
  @interval 2000

  def start do
    pid = spawn(__MODULE__, :chain, [:nil])
    Ticker.register(pid)
  end

  def chain(next) do
    receive do
      {:tick} when next == :nil ->
        IO.puts "tock in client #{inspect self}"
        :timer.sleep(@interval)
        send self, {:tick, self}
        chain(next)
      {:tick, pid} ->
        IO.puts "tock from client #{inspect pid}"
        :timer.sleep(@interval)
        send next, {:tick, self}
        chain(next)
      {:next, pid} ->
        chain(pid)
    end
  end
end
