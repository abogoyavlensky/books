defmodule Greater do
  import :timer, only: [sleep: 1]
  
  def greet(pid) do
    send pid, {:ok, "Hello!"}
    # raise "Exception!"
    exit("Exception!")
  end
  
  def run do
    # Process.flag(:trap_exit, true)
    # spawn_link(Greater, :greet, [self])
    spawn_monitor(Greater, :greet, [self])
    # It does not matter to waite or not the messages from child process
    # message goining to be recieved always
    # Monitor working the same way
    sleep(500)
    
    receive do
      msg -> IO.puts "RECEIVED MESSAGE #{inspect msg}"
    end
    receive do
      msg -> IO.puts "RECEIVED MESSAGE #{inspect msg}"
    end    
  end
end
