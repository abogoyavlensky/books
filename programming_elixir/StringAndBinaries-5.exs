defmodule MyModule do
  def center(list) do
     len = Enum.max_by(list, &String.length/1) |> String.length
     list |> Enum.each(_print(len))
  end

  defp _print(len) do
    fn word ->
      word_len = String.length(word)
      gaps = word_len + div(len - word_len, 2)
      IO.puts String.rjust(word, gaps)
    end
  end
end
