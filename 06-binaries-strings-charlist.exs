# Binaries, strings, and charlists

string = "hello"
IO.inspect(string)
IO.inspect(is_binary(string))

# Unicode and Code Points
# The unicode standars acts as an official registry of virtually all the characters we know: this
# includes characters from classical annd historical texts, emoji, annd formatting and control characters as well.

# Unicode organizes all of the characters in its repertoire into code charts, andn each character is given a unique numerical index.
# This numerical index is known as a Code Point

# In Elixir you can use a ? in front of a charater literal to reveal its code point:
IO.inspect(?a)
IO.inspect(?l)

# UTF-8 and Encodings
# Now that we understand what the Unicode standard is and what code points are, we can finally
# talk about encodingns. Whereas the code point is what we store, and encoding deals with how we store it:
# encoding is an implementation. In other words, we need a mechanism to convert the code point
# numbers into bytes so they can be stored in memory, writtenn to disk, etc.

string = "héllo"
IO.inspect(string)
IO.inspect(String.length(string))
IO.inspect(byte_size(string))

# Although the string above has 5 characters, it uses 6 bytes, as two bytes are used to represent the character é.

# If you wannt to see the exact bytes that a stringn would be stored in a file, a common trict is
# to concatenate the nnull byte <<0>> to it: in iex
"hello" <> <<0>>

# Alternatively, you can view a string's binary represenation by using IO.,inspect/2
IO.inspect("hello", binaries: :as_binaries)

# Bitstrings
# A bitstring is a fundamental data type in Elixir, denoted with the <<>> syntax.
# A bitstrinngn is a contiguous sequence of bits in memeory.

# By default, 8 bits(i.e. byte) is used to store each number in a bitstring, but
# you can manually specify the number of bits via a ::n modifier to denote the size
# in n bits, or you can use the more verbose declaration ::size(n):
IO.inspect(<<42>> == <<42::8>>)
IO.inspect(<<3::4>>)

# For example, the decimal number 3 when represented with 4 bits in base 2 would be 0011, which
# is equivalent to the values 0,0,1,1, ech stored using 1 bit:
IO.inspect(<<0::1, 0::1, 1::1, 1::1>> == <<3::4>>)

# Any value that exceeds what can be stored by the numbber of bits provisioned is truncated:
IO.puts(<<1>> == <<257>>)

# here, 257 in base 2 would be repsented as 100000001, but since we have reserved only
# 8 bits for its representation (by default), the left-most bit is ignored and the value
# becomes truncated to 00000001, or simply 1 in decimal

# Binaries
# A binary is a bitstring where the number of bits is divided by 8. That means the every
# binary is a bitstring, but not every bitstring is a binary. We can use is_bitstring/1 and
# is_binary/1
IO.inspect(is_bitstring(<<3::4>>))
IO.inspect(is_binary(<<3::4>>))
IO.inspect(is_bitstring(<<0, 255, 42>>))
IO.inspect(is_binary(<<0, 255, 42>>))
IO.inspect(is_binary(<<42::16>>))

# We can pattern match on binaries / bitstrings:
IO.inspect(<<0, 1, x>> = <<0, 1, 2>>)
IO.inspect(x)

# Note that unless you explicitly use :: modifiers, each entry in the binary pattern
# is expected to match a single byte (exactly 8 bits). If we want to match on a binary
# of unknown size, we can use the binary modifier at the end of the pattern:
<<0, 1, x::binary>> = <<0, 1, 2, 3>>
IO.inspect(x)

# There are a couple of other modifiers that can be useful when doing pattern matches
# on binaries. The binary-size(n) modifier will match n bytes in a binary:
<<head::binary-size(2), rest::binary>> = <<0, 1, 2, 3>>
IO.inspect(head)
IO.inspect(rest)

# A string is a UTF-8 encoded binary, where the code pointt for each character is
# encoded using 1 to 4 bytes. Thus every string is a binary, but due to the UTF-8 standard
# encoding rules, not every binary is a valid string.
IO.inspect(is_binary("hello"))
IO.inspect(is_binary(<<239, 191, 19>>))
IO.inspect(String.valid?(<<239, 191, 19>>))

# The string concatenation operator <> is actually a binary concatenation operator:
IO.inspect("a" <> "ha")
IO.inspect(<<0, 1>> <> "ha")

# Given that strings are binaries, we can also pattern match on strings:
<<head, rest::binary>> = "banana"
IO.inspect(head == ?b)
IO.inspect(rest)

# However, remember that binary pattern matching works on bytes, so matching on
# string like "über" with multiplebyte characters won't match on the character,
# it will match on the first byte of that character:
IO.inspect("ü" <> <<0>>)
IO.inspect("ü", binaries: :as_binaries)
<<x, rest::binary>> = "über"
IO.inspect(x == ?ü)
IO.inspect(rest)

# Above x, matched on only the fist byte of the multibyte ü charactter.

# Therefore, when pattern matching on strings, it is important to use the utf8 modifier:
IO.inspect(<<x::utf8, rest::binary>> = "über")
IO.inspect(x == ?ü)
IO.inspect(rest)

# Charlists
# A charlist is a list of integers where all the integers are valid code points.
IO.inspect(~c"hello")
IO.inspect([?h, ?e, ?l, ?l, ?o])
# The ~c sigil indicates the fact tthat we are dealing with a charlist and not a regular string.

# Instead of containing bytes, a charlist contains integer code pointts. However, the list tis only
# printed as a sigil if all code points are within the ASCII range
IO.inspect(~c"hełło")
IO.inspect(is_list(~c"hełło"))

# This is done to ease interoperability witth Erlang, even though it may lead
# to some surprising behavior. If you are storing a list of integers that happen
# to range between 0 and 127, by default IEX will interpret this as a charlist
# and it will display the corresponding ASCII characters.
heartbeats_per_minute = [99, 97, 116]
IO.inspect(heartbeats_per_minute)

# You can always force charlist to be printed in their list representation by calling
# inspect/2
IO.inspect(heartbeats_per_minute, charlists: :as_list)

# conver charlist to a string and back by using the to_string/1
res = to_charlist("hełło")
IO.inspect(to_string(res))
IO.inspect(to_string(:hello))
IO.inspect(to_string(1))

# The function above are polymorphic, in other words, they accept many shapes: not only
# do they convert charlist to strings (and vice-versa), they can also convert integers, atoms, and so on.

# String (binary) concatenationn use the <> operator but charlists, being lists, use the list concatenation operator ++
IO.inspect(~c"this " ++ ~c"fails")
