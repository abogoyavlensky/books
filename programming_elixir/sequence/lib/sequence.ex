defmodule Sequence do
  use Application

  def start(_type, _args) do
    initial_number = Application.get_env(:sequence, :initial_number)
    {:ok, pid} = Sequence.Supervisor.start_link(initial_number)
  end
end
