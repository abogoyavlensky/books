l = [1, 2, 3, 4]

IO.inspect Enum.map l, &(&1 + 2)
Enum.each l, &IO.inspect/1
