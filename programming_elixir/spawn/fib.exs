defmodule Fib do
  @moduledoc """
  Receives meaage from Scheduler and count fibbonaci number.
  """
  
  def fib(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:fib, n, client} -> 
        send client, {:answer, n, fib_calc(n), self}
        fib(scheduler)
      {:shutdown} -> exit(:normal)
    end
  end
  
  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n - 1) + fib_calc(n - 2)
end


defmodule Scheduler do
  @moduledoc """
  Schedule any function to calculate in any module and collect results.
  """
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self]) end)
    |> schedule_processes(to_calculate, [], func)
  end
  
  def schedule_processes(processes, queue, results, func) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [next | tail] = queue
        send pid, {func, next, self}
        schedule_processes(processes, tail, results, func)

      {:ready, pid} when length(processes) > 1 ->
        send pid, {:shutdown}
        schedule_processes(List.delete(processes, pid), queue, results, func)
      {:ready, pid} ->
        send pid, {:shutdown}
        Enum.sort(results,  fn {n1, _}, {n2, _} -> n1 <= n2 end)
        
      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [{number, result} | results], func)
    end
  end
end


to_process = [37, 37, 37, 37, 37, 37]
Enum.each 1..10, fn num_processes -> 
  {time, result} = :timer.tc(Scheduler, :run, [num_processes, Fib, :fib, 
                                               to_process])
  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #   time (s)"
  end
  :io.format "~2B       ~.2f~n", [num_processes,  time/1000000.0]
end
