defmodule MyTest do
  use ExUnit.Case, async: true

  @tag :external
  @tag os: :unix
  test "contacts external service" do
    # ...
  end
end

# In the example above, ExUnit stores the value of async: true in a module attribute to change
# how the module is compiled. Tags also work as annotations and they can be supplied multiple
# times, thanks to Elixir's ability to accumulate attribute. Then you can use tags to setup and filter
# test, such as avoiding executing Unix specific tests while running your test suite on windows.
