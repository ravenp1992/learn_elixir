# Recursion

# Elixir does not provide loop constructs. Instead we leverage recursion and
# high-level functions for working with collections.

# Due to immutability, loops inn Elixir(as in any functional programming language)
# are written differently from imperative languages.

# Data structures in Elixir are immutable. For this reason, functional languages
# rely on recursion: a function is called recursively until a condition is reached
# that stops the recursive action from continuinng. No data is mutated in this process.
# Consider the example below that prints a strinng an arbitrary number of times:

defmodule Recursion do
  def print_multiple_times(msg, n) when n > 0 do
    IO.puts(msg)
    print_multiple_times(msg, n - 1)
  end

  # This clause, also known as the termination clause, ignores the msg argument
  # by assigning it the _msg variable and returns the atom :ok
  def print_multiple_times(_msg, 0) do
    :ok
  end
end

Recursion.print_multiple_times("Hello!", 3)

# If you pass an argument that does not match any clause, Elixir raises
# a FunctionClauseError
# Recursion.print_multiple_times("Hello!", -1)

# Reduce and map algorithms
# Let's now see how we can use the power of recursion to sum a list of numbers:
# defmodule Math do
#   def sum_list([head | tail], accumulator) do
#     sum_list(tail, head + accumulator)
#   end

#   def sum_list([], accumulator) do
#     accumulator
#   end
# end
# IO.puts(Math.sum_list([1, 2, 3], 0))

# The process of takinng a list and reducing it down to one value is known as a
# reduce algorithm and is central to functional programming.

# What if we instead want to doulbe all of the values in our list?
defmodule Math do
  def double_each([head | tail]) do
    [head * 2 | double_each(tail)]
  end

  def double_each([]) do
    []
  end
end

IO.inspect(Math.double_each([1, 2, 3]))

# Here we have a recusion to traverse a list, doubling each element and returning
# a new list. The process of taking a list and mapping over it is known as a
# map algorithm.

# Recursion and tail call optimization are ann important part of Elixir and are
# commonly used to create loops. However, when programming in Elixir you will
# rarely use recusion as above to manipulate lists.

# The Enum module already provides conveniences for working with lists.
IO.inspect(Enum.reduce([1, 2, 3], 0, fn x, acc -> x + acc end))
IO.inspect(Enum.map([1, 2, 3], &(&1 * 2)))
IO.inspect(Enum.map([1, 2, 3], fn x -> x * 2 end))
