fizzbuzz = fn
  {0, 0, _} -> "FizzBuzz"
  {0, _, _} -> "Fizz"
  {_, 0, _} -> "Buzz"
  {_, _, x} -> x
end

IO.puts fizzbuzz.({0, 0, 1})
IO.puts fizzbuzz.({0, 1, 1})
IO.puts fizzbuzz.({1, 0, 1})
IO.puts fizzbuzz.({1, 2, 3})
