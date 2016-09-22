fizzbuzz = fn
  {0, 0, _} -> "FizzBuzz"
  {0, _, _} -> "Fizz"
  {_, 0, _} -> "Buzz"
  {_, _, x} -> x
end

a = fn n -> fizzbuzz.({rem(n, 3), rem(n, 5), n}) end

IO.puts a.(10)
IO.puts a.(11)
IO.puts a.(12)
IO.puts a.(13)
IO.puts a.(14)
IO.puts a.(15)
IO.puts a.(16)
