defmodule Stack.Server do
  use GenServer

  # External API implementoin

  def start_link(stack) do
    GenServer.start_link(__MODULE__, stack, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, {:pop})
  end

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end

  def status do
    :sys.get_status __MODULE__
  end
  # GenServer implementation

  def handle_call({:pop}, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_call(:stop, reason, reply, state) do
    {:noreply, state}
  end

  def handle_cast({:push, item}, stack) when item < 10  do
    {:stop, "Value #{inspect item} to push is not valid.", stack}
  end

  def handle_cast({:push, item}, stack) do
    {:noreply, [item | stack]}
  end

  def terminate(reason, stack) do
    IO.puts "Stack has been terminated."
    IO.puts "Reason: #{inspect reason}"
    IO.puts "State of the Stack: #{inspect stack}"
  end
end


defmodule Stack do
  use Application

  def start() do
    import Supervisor.Spec, warn: false
    children = [
      worker(Stack.Server, [[123, "cat"]]),
    ]

    opts = [strategy: :one_for_one, name: Stack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
