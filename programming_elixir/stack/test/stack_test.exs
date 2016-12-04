defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  import Supervisor.Spec, warn: false

  test "pop returns the first value from stack" do
    initial_stack = [123, "cat"]
    Stack.Supervisor.start_link(initial_stack)
    assert Stack.Server.pop == 123
  end
  test "push to stack works fine" do
    initial_stack = [123, "cat"]
    Stack.Supervisor.start_link(initial_stack)
    Stack.Server.push 10
    assert Stack.Server.pop == 10
  end
end
