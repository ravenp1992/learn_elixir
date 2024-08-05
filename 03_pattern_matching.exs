# Patterb matching

# = operator in Elixir is called the match operator and how to use it to pattern match
# inside data structures. the pin operator ^ to used to access previously bound values.

# The match operator
x = 1
IO.puts(1 = x)
# IO.puts(2 = x)

# Notice that 1 = x is a valid expression, and it matched because both the left and right side are equal to
# 1. When the sides do not match, a MatchError is raised.

# A variable can only be assigned on the leftt side of = 
# ** (CompilerError): undefined variable "unknown"
# 1 = unknown

# Pattern matching
# The match operator is not only used to match against simple values, but it is also useful for
# destructuring more complex data types.
tuple = {:hello, "world", 42}
{a, b, c} = tuple
IO.puts("#{a} #{b} #{c}")

# A pattern match erro will occur if the sides can't be matched,
# {a, b, c} = {:hello, "world"}

# And also when comparing differentt types,
# {a, b, c} = [:hello, "world", 42]

# We can match on specific values. The example below asserts that the left side will
# only match the right side when the right side is a tuple that starts with the atom :ok
{:ok, result} = {:ok, 13}
IO.puts(result)

# ** (MatchError) no match of right hand side value: {:error, :oops}
# {:ok, result} = {:error, :oops}

# pattern match on lists:
list = [:hello, "world", 42]
[a, b, c] = list
IO.puts("#{a} #{b} #{c}")

# A list also supports matchong on its own head and tail:
[head | tail] = [1, 2, 3]
IO.puts(head)
IO.inspect(tail)

# Similar to the hd/1 and tl/1 functions, we can't match an emptty list with a head and tail pattern:
# ** (MatchError) no match of right hand side value: []
# [head | tail] = []

# The [head | tail] format is not only used on pattern matching but also for prepending items to a list:
list = [1, 2, 3]
list = [0 | list]
IO.inspect(list)

# Pattern matching allows developers to easily destructure data types such as tuples and lists.
# It is one of the foundations of recursion in Elixir and applies to other types as well, like maps and binaries

# The pin operator

# Variable in Elixir can be rebound:
x = 1
x = 2

# However, there are times when we don't want variables to be rebound.
# Use the pin operator ^ when you want to pattern match agains a variable's existing value rather than rebinding the variable

# x = 1
# ^x = 2

# because we have pinned x when it vas bound to the value of 1, it is equivalent to the following:
# 1 = 2

# We can use the pin operator inside other pattern matches, such as tuples or lists:
x = 1
IO.inspect([^x, 2, 3] = [1, 2, 3])
IO.inspect({y, ^x} = {2, 1})
IO.puts(y)
# ** (MatchError) no mtach of right hand side value: {2, 2}
# IO.inspect({y, ^x} = {2, 2})

# Because x was bound to the value 1 when it was pinned, this last example could have been written
# as:
# {y, 1} = {2, 2}

# If a variable is mentioned more than once in a pattern, all references must bind to the same value:
# IO.inspect({x, x} = {1, 1})
# ** (MatchError) no match of right hand side value: {1, 2}
# IO.inspect({x, x} = {1, 2})

# In some cases, you don't care about a particular value in a pattern. It is common practice to bind those
# values to the underscore, _. For example, if only the head of the list matters to us, we can assign the
# tail to underscore.
[head | _] = [1, 2, 3]
IO.puts(head)
# The variable _ is special in that it can never be read from.

# Although pattern matching allows us to build powerful constructs, its usage is limited.
# For instance, you cannot make functions calls on the left side of a match.
# length([1, [2], 3]) = 3
