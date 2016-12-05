defmodule Frequency do
  def start_link do
    Agent.start_link(fn -> Map.new end, name: __MODULE__)
  end

  def add_word(word) do
    Agent.update(__MODULE__, fn dict ->
                                Dict.update(dict, word, 1, &(&1 + 1))
                             end)
  end

  def count_for(word) do
    Agent.get(__MODULE__, &(Dict.get(&1, word)))
  end

  def words do
    Agent.get(__MODULE__, &(Dict.keys(&1)))
  end
end
