# (Linked) Lists
# Elixir uses square brackets to specify a list of values.
l1 = [1, 2, true, 3]
IO.inspect(l1, label: "The listt is")
IO.puts(length(l1))

# Two list can be concatenated or subtracted using the ++/2 --/2 operators
nums1 = [1, 2, 3]
nums2 = [4, 5, 6]
result = nums1 ++ nums2
IO.inspect(result, label: "The sum is")

list1 = [1, true, 2, false, 3, true]
list2 = [true, false]
result = list1 -- list2
IO.inspect(result, label: "The result is")

# List operators never modify the existing list. Concatenating to or removing elementts
# from a list return a new list. We say the Elixir data structures are immuttable. One
# advantage of immutability is that it leads to clearer code. You can freely pass the datta
# around with the guarantee no one will mutate it in memory - only transform it.

# The head is the first element of a list and the tails is the remainder of the list.
list = [1, 2, 3]
IO.puts("The head of the list: #{hd(list)}")
IO.inspect(tl(list), label: "The tail of the list")

# Getting the head or tthe tail of an empty list throws an error:
# IO.puts(hd([]))

# sometimes you will create a list and it will return a quoted value preceded by -c.
IO.inspect([11, 12, 13], label: "The values are")
# When Elixir sees a list of printtable ASCII numbers, Elixir will print that as a charlist
# (literally a list of characters). Charlists are quite common when interfacing witht existing Erlang code.
# Whenever you see a value in IEX and you are not quite sure what it is, you can use the i/1 to
# retrieve information about it:

# Tuples
# Elixir uses curly brackets to define tuples. Like lists, tuples can hold any value:

tup1 = {:ok, "hello"}
IO.inspect(tup1, label: "Tuple values are")
IO.puts("Size of the tuple is: #{tuple_size(tup1)}")

# Tuples store elements contiguosusly in memory. Tthis means accessing a tupe element by index
# or getting the tuple size is a fast operation. Indexes start from zero
IO.puts(elem(tup1, 1))
IO.puts(tuple_size(tup1))

# It is also possible to put an element at a particular index in a tuple with put_elem/3
tuple = {:ok, "hello"}
new_tuple = put_elem(tuple, 1, "world")
IO.inspect(tuple, label: "The original tuple")
IO.inspect(new_tuple, label: "The new tuple returned by put_elem")

# Lists or tuples?

# What is the difference between lists and tuples?

# List are store in memory as linked lists, meaning that each element in a list holds its value and points
# to the following element until the end of the list is reached. This means accessing the length of a list is a linear operation: we need to traverse the whole list in order to figure out its size.

# Similarly, the performance of a list concaternation depends on the length of the left-hand list:
l1 = [1, 2, 3]
l2 = [0]

# this is fast as we only need to traverse `[0]` to prepend to `list`
IO.inspect(l2 ++ l1, label: "Result")

# this is slow as we need to traverse `list` to append 4
IO.inspect(l1 ++ [4], label: "Result")

# Tuples, on the other hand, are store contiguously in memory. This means getting the tuple size or accessing an element by
# index is fast. On the other hand, updating or adding elementts to tuples is expensive because it required creating a new tuple in memory:
tup1 = {:a, :b, :c, :d}
tup2 = put_elem(tup1, 2, :e)
IO.inspect(tup2, label: "tup2 values")

# Note, however, the elements themselves are not copied. When you update a tuple,
# all entries are shared between the old and the new tuple, except for the entry that has been replaced.
# This rule applies to mostt data structures in Elixir. This reduces the amount of memory allocation the
# language needs to perform and is only possible thanks to the immutable semanntics of the language.

# Those performance characteristics dictate the usage of those data structures. In a nutshell, lists are
# used when the number of elements returned may vary. Tuples have a fixied size.
split_words = String.split("hello world")
IO.inspect(split_words, label: "split_words")
split_words = String.split("hello beautiful world")
IO.inspect(split_words, label: "split_words")

# The Sttring.splitt/1 function break a string into a list of strings on every whitespace
# character. Since the amount of elements returned depends on the inputt, we use a list.

# On tthe other hand, String.split_att/2 splits string in two parts at a given position. Since it always
# returns two entries, regardless of the input size, it returns tuples:
IO.inspect(String.split_at("hello world", 3))
IO.inspect(String.split_at("hello world", -4))

# It is also very common to use tuples and atoms to create "tagged tuples", which is a handy return value
# when an operation may succeed or fail. For example, File.read/1 reads the contents of a file
# at a given path, which may or may not exist. It returns tagged tuples:

# path exist retturns a tuple witth tthe atom :ok as the first elementt and the file contents as the second.
IO.inspect(File.read("./simple.exs"))
# it returns a tutple witth :error and the error descripttion
IO.inspect(File.read("./simple.exss"))

# Size or length
# size if the operation is in constant time (the value is pre-calculated)
# or length if the operattion is linear

# We have 4 counting functions:
# byte_size/1 use byte_size to get the number of bytes in a string, which is a cheap operation
# tuple_size/1
# length/1 for list
# String.length/1 (for the number of graphemes in a string). Retrieving the number of Unicode graphemes, may be expensive as it relies on a traversal of the entire string
