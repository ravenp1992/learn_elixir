# IO and the file system

# input/output mechanisms, file-system-related tasks, and related modules such as IO, File, and Path.
# The IO system provides a great opportunity to shed some light on some philosophies and curiosities
# of Elixir and the Erland VM.

# The IO module
# The IO module is the main mechanism in Elixir for reading and writing to standard input/output
# (:stdio), standard error (:stderr), files, and other IO devices. Usage of the module is pretty
# straightforward:
# IO.puts("hello world")
# input = IO.gets("yes or no? ")
# IO.puts(input)

# By default, functions in the IO module read from the standard input and write to the standard output.
# We change change that by passing, for example, :stderr as an argument (in order to write to the standard error device):

# IO.puts(:stderr, "hello world")

# The File module

# The file module contains functions that allow us to open files as IO devices. By default, files
# are opened in binary mode, which requires developer to use the specific IO.binread/2 and IO.binwrite/2
# functions from the IO module:

# Potential data loss warning
# The following code opens a file for writing. If an existing file is available at the given path, its
# content will be deleted.

# {:ok, file} = File.open("./hello", [:write])
# IO.binwrite(file, "world")
# File.close(file)
# {:ok, bin} = File.read("./hello")
# IO.puts(bin)

# The version wiht ! returns the content of the file instead of a tuple, and if anything goes wrong
# the function raises an error.

# The version without ! is preferred when you want to handle different outcomes using pattern matching
# case File.read("./hellx") do
#   {:ok, content} -> IO.puts(content)
#   {:error, reason} -> IO.puts(:stderr, reason)
# end

# The Path module
# The majority of the function in the File module expect paths as arguments. Most commonly,
# those path will be regular binaries. The Path module provides facilities for working with such paths:

# foo/bar
# Path.join("foo", "bar")
# IO.inspect(Path.expand("~/hello"))

# Using functions from the Path module as opposed to directly manipulating strings is preferred since
# the Path module takes care of different operating systems transparently. Finally, keep in mind that
# Elixir will automatically convert slashes (/) into backslashes (\) on Windows when performing file
# operations.

# Processes
# You may have noticed that File.open/2 returns a tuple like {:ok, pid}:

pid =
  spawn(fn ->
    receive do: (msg -> IO.inspect("The message is : #{msg}"))
  end)

IO.write(pid, "hello")

# name = "Mary"
# IO.puts("Hello " <> name <> "!")

# name = "Mary"
# IO.puts(["Hello ", name, "!"])

# fruits = Enum.join(["apple", "banana", "lemon"], ",")
# IO.puts(fruits)

# fruits = Enum.intersperse(["apple", "banana", "lemon"], ",")
# IO.inspect(fruits)
