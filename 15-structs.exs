# Structs

# To define a struct, the defstruct/1 construct is used:
defmodule User do
  defstruct name: "Raven", age: 27
end

# The keyword list used with defstruct definens what fields the struct will have along with
# their default values. Structs take the name of the module they're defined in.

# We can now create User structs by using a syntax similar to the one used to create maps:
# %User{}
# %User{age: 27, name: "John"}

# Accessing and updatingn structs

john = %User{}
john.name
jane = %{john | name: "Jane"}

# ** (KeyError) key :oops not foundn in: %User{age: 27, name: "Jane"}
# %{jane | oops: :field}

# Structs are bare maps underneath
# Structs are simply maps with a "special" field named __struct__ that holds the name of the struct:
is_map(john)
john.__struct__

# However, structs do not inherit any of the protocols that maps do. For example, you can neither enumerate nor access a struct:
john = %User{}
john[:name]

# ** (UndefinedFunctionError) function User.fetch/2 is undefined (User does not implement the access behaviour)

Enum.each(john, fn {field, value} -> IO.puts(value) end)

# ** (Protocol.UndefinedError) protocl Enumerable not implemented for %User{age: 27, name: "John"} of type User (a struct)

# Default values and required keys
# If you don't specify a default key value when defining a struct, nil will be assumed:

defmodule Product do
  defstruct [:name]
end

%Product{}
# %Product{name: nil}

# You can define a structure combining both fields with explicit values, and implicit nil values.
# In this case you must first specify the fields which implicitly default to nil:
# Doing it in reverse order will raise a syntax error:
defmodule Post do
  defstruct [:description, title: "New Post"]
end

%Post{}
# %Post{title: "New Post", description: nil}

# You can also enforce that certain keys have to be specified when creating the struct via
# the @enforce_keys module attribute:
defmodule Car do
  @enforce_keys [:make]
  defstruct [:model, :make]
end

%Car{}
# ** (ArgumentError) the following keys must also be given when building struct Car: [:make]

# Enforcing keys provides a simple compile-time guarantee to aid developers when building
# structs. It is not enforced on updates and it does not provide any sort of value-validation.
