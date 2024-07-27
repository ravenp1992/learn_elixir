# Keyword lists and maps

# Associative data structures are able to associate a key to a certain value. Different
# languages call these different names like dictionaries, hashes, associative arrays, etc.

# Keyword lists are data-structure used to pass options to functions.
# Imagine you want to split a string of numbers. We can use String.split/2
IO.inspect(String.split("1 2 3", " "))

# However, what happens if tthere is an additional space between the numbers:
IO.inspect(String.split("1  2  3", " "))
# As you can see, there are now empty strings in our results.

# Luckily, the String.split/3 function allows trim option to be set to true:

# [trim: true] is a keyword list, Furthermore, when a keyword list is the last argument of a function,
# we can skip the brackets and write:
IO.inspect(String.split("1  2  3", " ", trim: true))

# As the name implies, keywords lists are simply lists. In particular, they are lists
# consisting of 2-item tuples where the first telement (the key) is an atom and the second
# can be any value. Both representations are the same:
IO.inspect([{:trim, true}] == [trim: true])

# Since keyword lists are lists, we can use all operations available to lists.
list = [a: 1, b: 2]
IO.inspect(list)
IO.inspect(list ++ [c: 3])
IO.inspect([a: 0] ++ list)

# You can read the value of a keyword list using the brackets syntax.
# This is also known as the access syntax, as it is defined by the Access module:
IO.inspect(list[:a])
IO.inspect(list[:b])

# In case of duplicate keys, values added to the front are the ones fetched:
new_list = [a: 0] ++ list
IO.inspect(new_list[:a])

# Keyword lists are important because they have three special characteristics:
# - keys must be atoms.
# - Keys are ordered, as specified by the developer.
# - keys can be given more than once.

# do-blocks and keywords
if true, do: IO.inspect("This will be seen"), else: IO.inspect("This won't")

# Maps as key-value pairs
# Whenever you need to store key-value pairs, maps are the "go to" data structure in Elixir.
# A map is created using the %{} syntax:
map = %{:a => 1, 2 => :b}
IO.inspect(map[:a])
IO.inspect(map[2])
IO.inspect(map[:c])
# Compare to keyword lists, we can already see two differences:
# - Maps allow any value as a key.
# - Maps keys do not follow any ordering.

# In constrast to keyword lists, maps are very useful with pattern matching. When a
# map is used in a pattern, it will always match on a subset of the given value:

IO.inspect(%{} = %{:a => 1, 2 => :b})
IO.inspect(%{:a => a} = %{:a => 1, 2 => :b})
IO.inspect(a)

# ** (MetchError) no match of right hand side value: %{2 => :b, :a => 1}
# IO.inspect(%{:c => c} = %{:a => 1, 2 => :b})

# As shown above, a map matches as long as the keys in the pattern exist in the given ma[.]
# Therefore an empty map matches all maps.

# The Map module provies a very similar API to the Keyword module with convenience
# functions to add ,remove, update maps keys:
IO.inspect(Map.get(%{:a => 1, 2 => :b}, :a))
IO.inspect(Map.put(%{:a => 1, 2 => :b}, :c, 3))
IO.inspect(Map.delete(%{:a => 1, 2 => :b}, 2))
IO.inspect(Map.to_list(%{:a => 1, 2 => :b}))

# Maps of predefined keys
# It is also common to create maps with a pre-defined set of keys.
# Their values may be updated, but new keys are never added nor removed.
# This is useful when we know the shape of the data we are working with and
# if we gett a different key, it likely means a mistake was done elsewhere.

# We define such maps using the same syntax as in the previous section, except that
# all keys must be atoms:
map = %{:name => "John", :age => 23}
IO.inspect(map)

# When the keys are atoms, in particular when working with maps of predefined keys,
# we can also access them using the map.key syntax:
IO.inspect(map.name)
IO.inspect(map.age)

# ** (KeyError) key :agee not found in: %{name: "John", age: 23}
# IO.inspect(map.agee)

# There is also syntax for updating keys, which also raises if the key has not yet been defined.
new_map = %{map | name: "Raven"}
IO.inspect(new_map)
IO.inspect(map)

# ** (KeyError) key :agee not found in: %{name: "John", age: 23}
# %{map | agee: 27}

# Nested dat structures

# Often we will have maps inside maps, or even keywords lists inside maps, and so forth.
# Elixir provides conveniences for manipulating nested data structures via the get_in/1, put_in/2, udpate_in/2,
# and other macros giving the same conveniences you would find in imperative languages while
# keeping the immutable properties of the language.

users = [
  raven: %{name: "Raven", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  kristine: %{name: "Kristine", age: 27, languages: ["HTML", "JavaScript", "CSS"]}
]

IO.inspect(users)
# We have a keyword list of users where each value is a map container the name, age
# and a list of programming languages each user likes. If we wanted to access the age
# for john, we could write:
IO.inspect(users[:raven].name)
IO.inspect(users[:raven].age)
IO.inspect(users[:raven].languages)

# It happens we can also use this same syntax for updating the value:
users = put_in(users[:raven].age, 31)
IO.inspect(users)
IO.inspect(users[:raven].age)

# The update_in/2 macro is similar but allows us to pass a function that controls
# how the value changes.
users = update_in(users[:kristine].languages, fn languages -> List.delete(languages, "CSS") end)
IO.inspect(users)

# There is more to learn about get_in/1, pop_in/1 and others, including the get_and_update_in/2
# that allows us to extract a value and update the data structure at once. There are also
# get_in/3, put_in/3, udpate_in/3, get_and_update_in/3, pop_in/2 which allow dynamic
# access into the data structure.

# As we conclude, remember that you should:
# - Use keyword lists for passing optional values to functions
# - Use maps for general key-value data structures
# - Use maps when working with data that has a predefined set of keys
