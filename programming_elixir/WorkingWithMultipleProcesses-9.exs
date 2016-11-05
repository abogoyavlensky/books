defmodule Handler do
  def handle(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:handle, path, word, pid} -> 
        send pid, {:answer, count_word(path, word), self}
      {:shutdown} -> exit(:normal)
    end
  end
  
  @doc """
  Count number of word appearance in file by path.
  """  
  def count_word(path, word) do
    path    
    |> File.read!
    |> String.split
    |> Enum.count(&(&1 == word))
  end
end


spawn(Handler, :handle, [self])

receive do
  {:ready, pid} -> send pid, {:handle, "cats/cats-001.txt", "cat", self}  
end

receive do
  {:answer, count, pid} -> 
    IO.puts inspect count
    send pid, {:shutdown}
end
