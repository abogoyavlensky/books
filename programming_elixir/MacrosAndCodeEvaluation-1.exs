defmodule Logic do
  defmacro unless(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(do_clause)
        val -> unquote(else_clause)
      end
    end
  end
end

defmodule Test do
  require Logic

  Logic.unless 1 == 2 do
    IO.puts("do")
  else
    IO.puts("else")
  end
end
