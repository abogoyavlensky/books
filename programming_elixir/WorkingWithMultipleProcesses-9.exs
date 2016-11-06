defmodule Handler do
  def handle(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:handle, args, pid} -> 
        send pid, {:answer, args, count_word(args), self}
        handle(pid)
      {:shutdown} -> exit(:normal)
    end
  end
  
  @doc """
  Count number of word appearance in file by path.
  """  
  def count_word([path: path, word: word]) do
    # Add sleep() to illustraite advantages of concurrent programming
    :timer.sleep(500)
    path
    |> File.read!
    |> String.split
    |> Enum.count(&(&1 == word))
  end
end


defmodule Scheduler do
  def run(module, dir, word) do
    files = dir |> File.ls! |> Enum.map(&("#{dir}/#{&1}"))
    files
    |> Enum.map(fn _ -> spawn(module, :handle, [self]) end)
    |> schedule_processes(files, word, [])
  end
  
  def schedule_processes(processes, queue, word, result) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [next | tail] = queue
        send pid, {:handle, [path: next, word: word], self}
        schedule_processes(processes, tail, word, result)
      
      {:ready, pid} when length(processes) > 1 ->
        send pid, {:shutdown}
        schedule_processes(List.delete(processes, pid), queue, word, result)
      {:ready, pid} -> 
        send pid, {:shutdown}
        result
              
      {:answer, [path: path, word: word], count, _pid} -> 
        schedule_processes(processes, queue, word, [{path, count} | result])
    end
  end
end
