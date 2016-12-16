defmodule Calc do
  defmacro explain(expr) do
    code = expr |> Macro.escape |> translate

    quote do
      IO.puts "Got: #{inspect unquote(code)}"
    end
  end

  @operators [:+, :-, :*, :/]
  @brackets :{}
  @match [+: "sum", -: "substruct", *: "multiple", /: "divide"]

  defp translate({operator, _, [left, right]}) when operator in @operators do
    "(#{@match[operator]} #{translate(left)} and #{translate(right)})"
  end
  defp translate({operator, _, args}) when operator == @brackets do
    translate(List.to_tuple(args))
  end
  defp translate(num), do: num

end


defmodule Test do
  import Calc, only: [explain: 1]

  explain 1 + 2
  explain 2 + 3 * 4
  explain 2 + 3 * 4 * 5
  explain 4 / 2 + 3 - 4 * 5
end
