list_concat = fn (l1, l2) -> l1 ++ l2 end

sum = fn a, b, c -> a + b + c end

pair_to_list = fn {a, b} -> [a, b] end

handle = fn
 {:ok, file} -> IO.puts "Read data #{IO.read(file, :line)} "
 {_, error} -> IO.puts "Error: #{:file.format_error(error)} "
end

handle.(File.open("hello.exs"))
handle.(File.open("hello_not_exists.exs"))