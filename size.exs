defprotocol Size do
  @doc """
  Calculate the size (and not the length!) of a data structure
  """
  def size(data)
end

defimpl Size, for: Any do
  def size(_), do: 0
end
