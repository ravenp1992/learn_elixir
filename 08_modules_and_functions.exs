# Modules and functions

# Compilation
# Most of the time it is convenient to write modules into files so they can be compiled and reused.
# Let's assume we have a file named math.ex with the following contents:
# defmodule Math do
#   def sum(a, b) do
#     a + b
#   end
# end

# This file can be compiled using elixirc:
# elixirc math.ex

# This will generate a file named Elixir.Math.beam containing the bytecode for the
# defined module. If we start iex again, our module definition will be available
# (provied that iex is started in the same directory the bytecode file is in):
# Math.sum(1,2)

# Elixir projects are usually organized into three directories:
# _build - contains compilation artifacts
# lib - contains Elixir code (usually .ex files)
# test - contains tests (usually .exs files)

# When working on actual projects, the build tool called mix will be responsible
# for compiling and setting up the proper paths for you. For learning and convenience purposes,
# Elixir also supports a scripting mode which is more flexible and does not generate
# any compiled artifacts

# Scripting mode
# In addition to the Elixir file extension .ex, Elixir also supports .exs files for scripting.
# Elixir treats both files exactly the same way, the only difference is in intention. .ex files are
# meant to be compiled while .exs files are used for scripting. This convention is followed by projects like mix.

# defmodule Math do
#   def sum(a, b) do
#     a + b
#   end
# end

# and execute it as:
# elixir math.exs

# Because we used elixir instead of elixirc, the module was compiled and loaded into
# memory but no .beam file was written to disk.

# Function definition
# Inside a module, we can defined functions with def/2 and private functions with defp/2.
# A function defined with def/2 can be invoked from other modules while a private function
# can only be invoked locally.

# Function declarations also support guards and multiple clauses. If a function has
# several clauses, Elixir will try each clause until it finds one that matches. Here is
# an implementation of a function that checks if the given number is zero or not:

# defmodule Math do
#   def zero?(0) do
#     true
#   end

#   def zero?(x) when is_integer(x) do
#     false
#   end
# end

# IO.puts Math.zero?(0)         #=> true
# IO.puts Math.zero?(1)         #=> false
# IO.puts Math.zero?([1, 2, 3]) #=> ** (FunctionClauseError)
# IO.puts Math.zero?(0.0)       #=> ** (FunctionClauseError)

# The trailing question mark in zero? means that this function returns a boolean.

# Default arguments
# Function definitions in Elixir also support default arguments:

# defmodule Concat do
#   def join(a, b, sep \\ " ") do
#     a <> sep <> b
#   end
# end

# IO.puts(Concat.join("Hello", "world"))
# IO.puts(Concat.join("Hello", "world", "_"))

# Any expression is allowed to server as a default value, but it won't be evaluated
# during the function definition. Every time the function is invoked and any of its
# default values have to be used, the expression for the default value will be evaluated:

defmodule DefaultTest do
  def dowork(x \\ "hello") do
    x
  end
end

IO.puts(DefaultTest.dowork())
IO.puts(DefaultTest.dowork(123))
IO.puts(DefaultTest.dowork())

# If a function with default values has multiple clauses, it is required to create
# a function head(a function definition without a body) for declaring defaults:

# defmodule Concat do
#   # A function head declaring defaults
#   def join(a, b \\ nil, sep \\ " ")

#   def join(a, b, _sep) when is_nil(b) do
#     a
#   end

#   def join(a, b, sep) do
#     a <> sep <> b
#   end
# end

# IO.puts(Concat.join("Hello", "world"))
# IO.puts(Concat.join("Hello", "world", "_"))
# IO.puts(Concat.join("Hello"))

# When using default values, one must be careful to avoid overlapping function definitions.
# Consider the following example:

defmodule Concat do
  def join(a, b) do
    IO.puts("**First join")
    a <> b
  end

  def join(a, b, sep \\ " ") do
    IO.puts("**Second join")
    a <> sep <> b
  end
end

# The compiler is telling us that invoking the join function with two arguments
# will always choose first definition of join whereas the second one will only
# be invoked when three arguments are passed:
