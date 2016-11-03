defmodule Parallel do
  def add(pid, elem, fun) do
    :timer.sleep(500)
    send pid, {self, fun.(elem)}
  end
  
  def pmap(collection, fun) do
    collection
    |> Enum.map(&(spawn_link(Parallel, :add, [self, &1, fun])))
    |> Enum.map(&(receive do {^&1, result} -> result end))    
  end
end
