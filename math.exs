defmodule Math do
  def sum(a, b) do
    a + b
  end

  defp do_sum(a, b) do
    a + b
  end

  def zero?(0) do
    true
  end

  def zero?(x) when is_integer(x) do
    false
  end
end

IO.puts(Math.sum(1, 2))
# ** (UndefinedFunctionError)
# IO.puts(Math.do_sum(1, 2))

IO.puts(Math.zero?(0))
IO.puts(Math.zero?(1))

# ** (FunctionClauseError)
# IO.puts(Math.zero?([1, 2, 3]))
# IO.puts(Math.zero?(0.0))
