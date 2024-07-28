# Enumerables and Streams

# While Elixir allows us to write recursive code, most operations we perform
# on a collections is done with the help of the Enum and Stream modules.

# Enumerables
# Elixir provides the concept of enumerables and the Ennum module to work with them.
# lists and maps are enumerables:

# IO.inspect(Enum.map([1, 2, 3], &(&1 * 2)))
IO.inspect(Enum.map([1, 2, 3], fn x -> x * 2 end))
IO.inspect(Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k * v end))

# The Enum module provides a huge range of functions to transform, sort, group, filter
# and retrieve items from enumerables. It is one of the module developers use frequently in
# their Elixir code.

# Elixir also provides ranges which are also enumerable:
IO.inspect(Enum.map(1..3, fn x -> x * 2 end))
IO.inspect(Enum.reduce(1..3, 0, &+/2))

# The functions in the Enum modules are limited to, as the name says, enumerating
# values in data structures. For specific operations, like inserting and updating
# particular elements, you may need to reach for module specific to the data type.
# For example, if you want to insert an element at a given position in a list, you
# should use the List.insert_at/3 function.

# The functions in the Enum module can work with any data type that implements the
# Enumerable protocol.

# Eager vs Lazy
# All the functions in the Enum module are eager. Many function expect an enumerable
# and return a list back:
odd? = fn x -> rem(x, 2) != 0 end
IO.inspect(Enum.filter(1..3, odd?))

# This means that when performing multiple operations with Enum, each operation
# is going to generate an intermediate list until we reach the result:
IO.inspect(1..100_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(odd?) |> Enum.sum())

# The example above has a pipeline of operations. We start with a range then
# multiply each element in the range by 3. This first operation will now create
# and return a list with 100_000 items. Then we keep all odd elements from the list,
# generating a new list, now with 50_000 items, and then we sum all entries.

# The pipe operator
# The |> symbol used in the snippet above is the pipe operator: it takes the output
# from the expression on its left side and passes it as the first argument to the
# function on its right side. Its purpose is to highlight the data being transformed by
# a series of functions. To see how it can make the code cleaner

# code written without using the |> operator:
IO.inspect(Enum.sum(Enum.filter(Enum.map(1..100_000, &(&1 * 3)), odd?)))

# Streams
# As an alternative to Enum, Elixir provides the Stream module which supports
# lazy operations:
IO.inspect(1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum())

# Streams are lazy, composable enumerables.

# In the example above, 1..100_000 |> Stream.map(&(&1 * 3)) returns a data type,
# an actual stream, that represents the map computation over the range 1..100_000

1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?)
# Instead of generating intermediate lists, streams build a series of computations
# that are invoked only when we pass the underlying stream to the Enum module.
# Streams are useful when working with large, possibly infinite, collections.

# Many functions in the Stream module accept any enumerable as an argument and
# return a stream as a result. It also provides functions for creating streams.
# For example, Stream.cycle/1 can be used to create a stream that cycles a given
# enumerable infinitely. Be careful to not call a function like Enum.map/2 on
# such streams, as they would cycle forever:
stream = Stream.cycle([1, 2, 3])
IO.inspect(Enum.take(stream, 10))

# On the other hand, Stream.unfold/2 can be used to generate values from a given initial value:
stream = Stream.unfold("hello", &String.next_codepoint/1)
IO.inspect(Enum.take(stream, 3))

# Another interestingn function is Stream.resource/3 which can be used to wrap
# around resources, guaranteeing they are opened right before enumeration and closed afterwards,
# even in the case of failure. For example, File.stream!/1 builds on top of
# Stream.resource/3 to stream files:
stream = File.stream!("math.exs")
IO.inspect(Enum.take(stream, 10))

# The example above will fetch the first 10 lines of the file you have selected.
# This means streams can be very useful for handling large files or even slow
# resources like network resources.
