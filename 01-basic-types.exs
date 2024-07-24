# integer
IO.puts(1)

# integer
IO.puts(0x1F)

# float
IO.puts(1.0)

# boolean
IO.puts(true)

# atom / symbol
IO.puts(:atom)

# string
IO.puts("string")

# list
# IO.puts([1, 2, 3])

# tuple
# IO.puts({1, 2, 3})

# Basic arithmetic
IO.puts(1 + 2)
IO.puts(5 * 5)
# / always return a float
IO.puts(10 / 2)

# If you want to do integer division or get the division remainder
IO.puts(div(10, 2))
IO.puts(rem(10, 3))

# binary
IO.puts(0b1010)
# octal
IO.puts(0o777)
# hexadecimal
IO.puts(0x1F)

# Float numbers require a dot followed by at least one digit and also support e for scientific notation
# Floats in Elixir are 64-bit precision.
IO.puts(1.0)
IO.puts(1.0e10)
IO.puts(1.010)
# round
IO.puts(round(3.58))
IO.puts(trunc(3.58))

IO.puts(is_integer(1))
IO.puts(is_integer(2.0))
# check to see if value is integer or floatt
IO.puts(is_number(true))

# identifying functions and documentations using iex: h trunc/1
# Most often you also include the module name when looking up the documentation for a given function: h Kernel.trunc/1

IO.puts(true)
IO.puts(false)
IO.puts(true and true)
IO.puts(false or is_boolean(true))
IO.puts(not true)

# or and and are short-circuit operators.
# false and raise("This error will nevber be raised")
# true or raise("This error will nevber be raised")

# nil inidicate the absence of  a value.
# and a set tof logical operattors that also manipulate nil: ||/2, &&/2, and !/1.
# for these operators, false and nil are considered "falsy", all other values are "truthy"
IO.puts(1 || true)
IO.puts(false || 11)
# nil
IO.puts(nil && 13)
IO.puts(true && 17)
IO.puts(!true)
IO.puts(!1)
IO.puts(!nil)
# values like 0 and "", which some other programming languages consider to be "falsy",
# are "truthy" in Elixir.

# Atoms is a constant whose v alue is its own name. Some other languages call these symbols.
# They are often useful to enumerate over distinct values, such as:
IO.puts(:apple)
IO.puts(:orange)
IO.puts(:watermelon)

# Atoms are equal if their names are equal
IO.puts(:apple == :apple)
IO.puts(:orange == :apple)

# Often they are used to express the state of an operation, by using values
# such as :ok and :error. The boolean true and false are also atoms:
# Elixir allows you to skip the leading : for the atom false, true and nil
IO.puts(true == true)
IO.puts(is_atom(false))
IO.puts(is_atom(nil))
IO.puts(is_boolean(false))

# Strings
IO.puts("hello")
# you can concatenate two strings witth the <>/2 operator
IO.puts("hello " <> "world!")
# string interpolation
string = "world"
IO.puts("hello #{string}!")

# interpolattion supports any data type that may be converted to a string:
number = 42
IO.puts("I am #{number} years old!")

# String line breaks in them. You can introduce them using escape sequences:
IO.puts("hello
world")
IO.puts("hello\nworld")

# string are represented internally by contiguous sequences of bytes known as binaries:
IO.puts(is_binary("hello"))
# We can also get the number of bytes in a string:
IO.puts(byte_size("hello"))

# Notice that the number of bytes in that string is 6, even though it has 5 graphemes.
# that's because the grapheme "ö" takes 2 bytes to be reprensted in UTF-8.
IO.puts(byte_size("hellö"))
# We can get the actual length of the string, base on the number of graphemes,
IO.puts(String.length("hellö"))

# String module contains a bunch of functions that operate on strings as defined
# in the Unicode standard:
IO.puts(String.upcase("hellö"))

# Structural comparison
# ==, !=, <=, >=, < and >
# we can compare numbers
IO.puts(1 == 1)
IO.puts(1 != 2)
IO.puts(1 < 2)
# but also atoms, strings, booleans, etc:
IO.puts("foo" == "foo")
IO.puts("foo" == "bar")
IO.puts(1 == 1.0)
IO.puts(1 == 2.0)
# strict comparision operator === and !== if you want to distinguish between integers and floats
