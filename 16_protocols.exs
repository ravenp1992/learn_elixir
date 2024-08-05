# Protocols
# Protocols are a mechanism to achieve polymorphism in Elixir where you want the behavior to
# vary depending on the data type. We are already familiar with one way of solving this type of
# problem: via pattern matching and guard clauses. 

defprotocol Utility do
  @spec type(t) :: String.t()
  def type(args)
end

defimpl Utility, for: BitString do
  def type(_value), do: "string"
end

defimpl Utility, for: Integer do
  def type(_value), do: "integer"
end

# Utility.type("foo")

defprotocol Size do
  @doc """
  Calculate the size (and not the length!) of a data structure
  """
  def size(data)
end

defimpl Size, for: BitString do
  def size(string), do: byte_size(string)
end

defimpl Size, for: Map do
  def size(map), do: map_size(map)
end

defimpl Size, for: Tuple do
  def size(tuple), do: tuple_size(tuple)
end

defimpl Size, for: MapSet do
  def size(set), do: MapSet.size(set)
end

Size.size("foo")
Size.size({:ok, "hello"})
Size.size(%{label: "some label"})

# Passing a data type that doesn't implement the protocol raises an error:
# It's possible to implement protocols for all Elixir data types:
# Atom, BitString, Float, Function, Integer, List, Map, PID, Port, Reference, Tuple

# Implementing Any
# We can explicitly derive the protocol implementation for our types or automatically
# implement the protocol for all types. In both cases, we need to implement the protocol
# for Any.

# Deriving
# Elixir allows us to derive a protocol implementation based on the Any implementation.

defimpl Size, for: Any do
  def size(_), do: 0
end

defmodule User2 do
  @derive [Size]
  defstruct [:name, :age]
end

# Fallback to Any

defprotocol Size do
  @fallback_to_any true
  def size(data)
end

defimpl Size, for: Any do
  def size(_), do: 0
end

# Elixir developers prefer explicit over implicit, you may see many libraries pushing
# towards the @derive approach.
