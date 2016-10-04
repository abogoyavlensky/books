IO.puts :io.format("This is number ~4.2f~n", [5.678])

IO.puts System.get_env("HOME")

IO.puts Path.extname("dave/test.exs")

IO.puts System.cwd()

IO.puts "Use poison lib to convert json to data."

IO.puts System.cmd "ls", []
