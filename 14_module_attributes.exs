# Module attributes

# Module attributes in Eliir serve three purposes:
# 1. as module and function annotations
# 2. as temporary module storage to be used during compilation
# 3. as compile-time constants
defmodule MyServer do
  @moduledoc """
  My server code
  """
end

# @moduledoc -- provides documentation for the current module
# @doc -- provides documentation for the function or macro that follows the attribute.
# @spec -- provdes a typespe for the function that follows the attribute.
# @behaviour -- (notice the British spelling) used for specifying an OTP or user-defined behaviour.

defmodule Math do
  @moduledoc """
  Provides math-related functions.

  ## Examples

    iex> Math.sum(1, 2)
    3
  """

  @doc """
  Calculates the sum of two numbers
  """
  def sum(a, b) do
    a + b
  end
end

# As temporary storage
defmodule AnotherServer do
  @service URI.parse("https://example.com")
  IO.inspect(@service)
end

# Do not add a newline between the attribute and its value, otherwise Elixir will assume you
# are reading the value, rather than setting it.

# Attributes can also be read inside functions:
defmodule MyApp.Status do
  @service URI.parse("https://example.com")
  def status(email) do
    SomeHttpClient.get(@service)
  end
end

# The module attribute is defined at compile time and its return value, not the function call
# itself, is what will be substituted in for the attribute. So the above will effectively compile to this:

defmodule MyApp.Status do
  def status(email) do
    SomeHttpClient.get(%URI{
      authority: "Example.com",
      host: "example.com",
      port: 443,
      scheme: "https"
    })
  end
end

# Generally speaking, you want to avoid reading the same attribute multiple times and instead move
# it to function. For example, instead of this:

# def some_func, do: do_something_with(@example)
# def another_func, do: do_something_else_with(@example)

# prefer this:

def some_func, do: do_something_with(example())
def another_func, do: do_something_else_with(example())
defp example, do: @example

# As compile-time constant

# Module attributes may also be useful as compile-time constants. Generally speaking, functions
# themselves are sufficient for the role of constant in a codebase. For example, instead of defining:

# @hours_in_a_day 24

# you should prefer:
defp hours_in_a_day(), do: 24

# It is common in many projects to have a module called MyApp.Constants that defines all
# constant used throughout the codebase.

# You can even have composite data structures as constants, as long as they are made
# exclusively of other data type (no function calls, no operators, and no other expression).
# For example, you may specify a system configuration constant as follows:

defp system_config(), do: %{timezone: "Etc/UTC", locale: "pt-BR"}

# Given data structures in Elixir are immutable, only a single instance of the data structure
# above is allocated and shared across all functions calls, as lonng as it doesn't have any
# executable expression.

# The use case for module attributes arise when you need to do some work at compile-time
# and then inject its results inside a function. A common scenario is module attributes
# inside patterns and guards (as an alternative to defguard/1), since they only support
# limited set of expressions:

# Inside pattern
@default_timezone "Etc/UTC"
def shift(@default_timezone), do: ...

# Inside guards
@time_periods [:am, :pm]
def shift(time, period) when perio in @time_period, do: ...
