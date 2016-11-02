defmodule Spawn do
  def returner(_n) do
    receive do
      {sender, token} -> send sender, {:ok, token}
    end
  end
end

 
[firstp, secondp] = Enum.map 0..1, &(spawn(Spawn, :returner, [&1]))

send secondp, {self ,"fred"}
send firstp, {self, "betty"}

receive do
  {:ok, token} -> IO.puts token
  after 500 -> "Thera no any messages"
end

receive do
  {:ok, token} -> IO.puts token
  after 500 -> "Thera no any messages"
end

"""
Первым возвращает значение тот процесс, который был запущен первым, 
даже если сообщение ему отправили во вторую очередь.
"""
