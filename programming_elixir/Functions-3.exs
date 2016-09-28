fizzbuzz = fn
  {0, 0, _} -> "FizzBuzz"
  {0, _, _} -> "Fizz"
  {_, 0, _} -> "Buzz"
  {_, _, x} -> x
end

a = fn n -> fizzbuzz.({rem(n, 3), rem(n, 5), n}) end

p = fn n -> IO.puts a.(n) end

Enum.map 10..16, p
