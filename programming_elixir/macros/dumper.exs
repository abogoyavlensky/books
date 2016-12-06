defmodule My do
  defmacro macro(param) do
    IO.inspect param
  end
end

defmodule Test do
  require My

  My.macro :atom
  My.macro do
    1
  end
  My.macro do: (a = 1; a + a)
end
