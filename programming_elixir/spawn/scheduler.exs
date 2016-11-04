defmodule Scheduler do
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
