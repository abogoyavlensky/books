defmodule Sequence do
  use Application

  def start(_type, _args) do
    {:ok, pid} = Sequence.Supervisor.start_link(123)
  end
end
