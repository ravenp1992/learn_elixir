# Anonymous functions
# anonymous functions allow us to store and pass executable code around as if it was an
# integer or a string.

# Defining anonymous functions

add = fn a, b -> a + b end
IO.puts(add.(1, 2))
IO.puts(is_function(add))
# We can invoke anonymous functions by passing argument to it. Note that a dot (.) between
# the variable parentheses is required to invoke an nonymous function. The dot makes it clear
# when you are calling an anonymous function, stored in the variable add, opposed to a function name add/2

# Anonymous functions in Elixir are also identified by the number of arguments they receive.
# We can check if a function is of any given arity by using is_function/2:
IO.puts(is_function(add, 2))
IO.puts(is_function(add, 1))

# Closure
# Anonymous function can also access variables that are in scope when the function is defined.
# This is typically referred to as closures, as they close over their scope.

double = fn a -> add.(a, a) end
result = double.(4)
IO.puts("The result is #{result}")

# A variable assigned inside a function does not affectt its surrounding environment:
x = 42
(fn -> x = 0 end).()
IO.puts(x)

# Clauses and guards
# Similar to case/2, we can pattern match on the arguments of anonymous functions as well as
# define multiple clauses and guards:
# The number of arguments in each anonymous function clause needs to be the same, otherwise an error is raised.
f = fn
  x, y when x > 0 -> x + y
  x, y -> x * y
end

IO.puts(f.(1, 3))
IO.puts(f.(-1, 3))

# The capture operator
# We have been using the notationn name/arity to refer to functions. It happens
# that this notation can actually be used to capture an existing function into a
# data-type we can pass around, similar to how anonymous functions behave.

fun = &is_atom/1
IO.inspect(fun)
IO.puts(is_function(fun))
IO.puts(fun.(:hello))
IO.puts(fun.(123))

# As you can see, once a function is captured, we can pass it as argument or invoke it using the
# anonymous function notation. The returned value above also hints we can capture functions
# defined in modules:
fun = &String.length/1
IO.inspect(fun)
IO.puts(fun.("hello"))

# You can also capture operators
add = &+/2
IO.inspect(add)
IO.puts(add.(1, 3))

# The capture syntax can also be used as a shortcut for creating functions.
# This is handy when you want to create functions that are mostly wrapping existing functions or operators.

fun = &(&1 + 1)
IO.inspect(fun)
IO.puts(fun.(1))

fun = &"Good #{&1}"
IO.puts(fun.("morning"))

# The &1 represents the first argument passed into the function. &(&1 + 1) above
# is extacly the same as fn x -> x + 1 end.
