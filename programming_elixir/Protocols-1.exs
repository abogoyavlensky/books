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

  def _shift(char, shift) do
    result = char + shift
    delta = result - @last
    if delta > 0 do
      @first + delta
    else
      result
    end
  end
end

defimpl Caesar, for: Any do
  def encrypt(_string, _shift), do: "Argument must be String or List"
  def rot13(_string), do: "Argument must be String or List"
end


IO.inspect Caesar.encrypt('abcxz', 1)
IO.inspect Caesar.encrypt("abcxz", 1)

IO.inspect Caesar.rot13('abcxz')
IO.inspect Caesar.rot13("abcxz")
