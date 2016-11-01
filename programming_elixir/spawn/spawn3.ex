defmodule Spawn3 do
  def greet do
    receive do
      {sender, msg} -> send sender, {:ok, "Hello, #{msg}"}
    end
  end
end

pid = spawn(Spawn3, :greet, [])
send pid, {self, "World!"}

receive do
  {:ok, msg} -> IO.puts msg
end

send pid, {self, "Kermit!"}

receive do
  {:ok, msg} -> IO.puts msg
after 3000 -> IO.puts "The greeter has gone away"
end
