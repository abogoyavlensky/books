defmodule Tracer do
  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  defmacro def(definition={:when, _, [{name, _, args}, _]}, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts "==> call: #{Tracer.dump_defn(unquote(name), unquote(args))}"
        result = unquote(content)
        IO.puts "<== result: #{result}"
      end
    end
  end
  defmacro def(definition={name, _, args}, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts "==> call: #{Tracer.dump_defn(unquote(name), unquote(args))}"
        result = unquote(content)
        IO.puts "<== result: #{result}"
      end
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [def: 2]
      import unquote(__MODULE__), only: [def: 2]
    end
  end
end

defmodule Test do
  use Tracer

  def puts_some_three(a, b, c), do: IO.inspect(a + b + c)
  def add_list(list), do: Enum.reduce(list, &(&1 + &2))
  def sum(a, b) when a > b, do: a + b
  def sum(a, b), do: a + 1
end

Test.puts_some_three 1, 2, 3
Test.add_list [5, 6, 7, 8]
Test.sum 6, 2
Test.sum 3, 8
