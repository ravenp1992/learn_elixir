# case, cond, and if

# case
# case allows us to compare a value against many pattern until we find a matching one:
tuple = {1, 2, 3}

case tuple do
  {4, 5, 6} ->
    IO.puts("This clause won't match")

  {1, x, 3} ->
    IO.puts("This clause will match and bind x to #{x} in this clause")

  _ ->
    IO.puts("This clause would match any value")
end

# If you want to pattern match against an existing variable, you need to use the ^ operator
x = 1

case 10 do
  ^x -> IO.puts("Wont match")
  _ -> IO.puts("Will match")
end

# Clauses also allow extra conditions to be specified via guards:
case {1, 2, 3} do
  {1, x, 3} when x > 0 -> IO.puts("Will match")
  _ -> IO.puts("Would match, if guard condition were not satisfied")
end

# Keep in mind errors in guards do not leak but simply make the guard fail:
# hd(1)
case 1 do
  x when hd(x) -> IO.puts("won't match")
  x -> IO.puts("Got #{x}")
end

# If none of the clauses match, an error is raised:
# case :ok do
#   :error -> "Won't match"
# end

# if/unless
# case builds on pattern matching and guards to destructure and match on certain conditions.
# However patterns and guards are limited only to certain expression which are optimized by the compiler.
# In many situations, you need to write conditions that go beyond what can be expressed with case.
# For those, if/2 (and unless/2) are useful alternatives:

if true do
  IO.puts("This works!")
end

unless true do
  IO.puts("This will never be seen")
end

# If the condition given to if/2 return false or nil, the body given between do - end is not executed
# and instead it returns nil. The opposite happens with unless/2

# They also support else block (although using else with unless is generally discourage):
if nil do
  IO.puts("This won't be seen")
else
  IO.puts("this will")
end

# If any variable is dedclared or changed inside if, case, and similar constructs, the declaration
# and change will only be visible inside the construct.
x = 1

if true do
  x = x + 1
end

IO.puts(x)

# In said cases, if you want to change a value, you must return the value from the if:
x = 1

x =
  if true do
    x + 1
  else
    x
  end

IO.puts(x)

# An interesting note regard if/2 and unless/2 is that they are implementted as
# macros in the language: they aren't special language constructs as they be in many languages.

# If you find yourself nesting severial if/2 blocks, you may want to consider using cond/1 instead.
cond do
  2 + 2 == 5 -> IO.puts("This will not be true")
  2 * 2 == 3 -> IO.puts("nor this")
  1 + 1 == 2 -> IO.puts("But thil will")
end

# This is equivalentt to else if clauses in many imperative languages - although used less
# frequently in Elixir.

# If all of conditions return nil or false, an erro (CondClauseError) is raised.
# For this reason, it may be necessary to add a final condition, equal to true
cond do
  2 + 2 == 5 -> IO.puts("This is never true")
  2 * 2 == 3 -> IO.puts("Nor this")
  true -> IO.puts("This is always true (equivalent to else)")
end

# Similar to if/2 and unless/2, cond considers any value besides nil and false to be true:
cond do
  hd([1, 2, 3]) -> IO.puts("1 is considered as true")
end
