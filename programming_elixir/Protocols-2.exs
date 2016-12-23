defprotocol Caesar do
  @fallback_to_any true
  def encrypt(string, shift \\ 0)
  def rot13(string)
end

defimpl Caesar, for: [BitString, List] do
  @first ?a - 1
  @last ?z
  @rot13_shift 13

  def encrypt(string, shift) when is_list(string) do
    string
    |> Enum.map(&_shift(&1, shift))
  end
  def encrypt(string, shift) when is_bitstring(string) do
    string
    |> to_charlist
    |> Enum.map(&_shift(&1, shift))
    |> to_string
  end

  def rot13(string) do
    encrypt(string, @rot13_shift)
  end

  def _shift(char, shift) when @first < char < @last do
    result = char + shift
    delta = result - @last
    if delta > 0 do
      @first + delta
    else
      result
    end
  end
  def _shift(char, shift), do: char
end

defimpl Caesar, for: Any do
  def encrypt(_string, _shift), do: "Argument must be String or List"
  def rot13(_string), do: "Argument must be String or List"
end


defmodule WordList do
  @name __MODULE__

  def start_link do
    Agent.start_link(fn -> [] end, name: @name)
  end

  def load_from_files(dir) do
    {:ok, file_names} = File.ls(dir)
    file_names
    |> Stream.map(fn name -> Task.async(fn -> add_words("#{dir}/#{name}") end) end)
    |> Enum.map(&Task.await/1)
  end
  def add_words(file_name) do
    Agent.update(@name, &do_add_words(&1, file_name))
  end
  def get_words do
    Agent.get(@name, &(&1))
  end
  def get_matches do
    list = get_words
    list
    |> Enum.filter_map(&match_word?(&1, list), &do_keyword/1)
  end

  defp do_add_words(list, file_name) do
    Enum.uniq(list ++ load_from_file(file_name))
  end
  defp load_from_file(file_name) do
    File.stream!(file_name, [], :line)
    |> Enum.map(&String.strip/1)
  end
  defp match_word?(word, list) do
    Caesar.rot13(word) in list
  end
  defp do_keyword(word) do
    # %{word => Caesar.rot13(word)}
    word
  end
end


WordList.start_link
WordList.load_from_files "words"
WordList.get_matches

# IO.puts Caesar.rot13 "ärtner"
