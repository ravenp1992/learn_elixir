require Integer

# Alias the module so it can be called as Bar instead of Foo.bar
# alias Foo.Bar, as: Bar

# Require the module in order to use its macros
# require Foo

# Import functions from Foo so they can be called without the `Foo.` prefix
# import Foo

# Invokes the custom code defined in Foo as an extension Point
# use Foo

IO.inspect(Integer.is_odd(3))

defmodule AssertionTest do
  use ExUnit.Case, async: true

  test "always pass" do
    assert true
  end
end
