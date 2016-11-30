defmodule Stack.Server do
  use GenServer

  # External API implementoin

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
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

  def init(stash_pid) do
    stack = Stack.Stash.get_value stash_pid
    {:ok, {stack, stash_pid}}
  end

  def handle_call({:pop}, _from, {[head | tail], stash_pid}) do
    {:reply, head, {tail, stash_pid}}
  end

  def handle_call(:stop, _reason, _reply, {stack, stash_pid}) do
    {:noreply, {stack, stash_pid}}
  end

  def handle_cast({:push, item}, {stack, _stash_pid}) when item < 10  do
    raise "ERROR"
  end

  def handle_cast({:push, item}, {stack, stash_pid}) do
    {:noreply, {[item | stack], stash_pid}}
  end

  def terminate(reason, {stack, stash_pid}) do
    IO.puts "Stack has been terminated."
    IO.puts "Reason: #{inspect reason}"
    IO.puts "Save state of the Stack: #{inspect stack}"
    Stack.Stash.save_value stash_pid, stack
  end
end
