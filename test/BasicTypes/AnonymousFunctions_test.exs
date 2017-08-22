defmodule AnonymousFunctionsTest do
  use ExUnit.Case

  @doc """
  Anonymous functions are closures, therefore they can access variables are in
  scope when the function is defined.
  """
  test "anonymous function" do
    add = fn a, b -> a + b end
    assert is_function(add)

    # Add function expects 2 arguments. arity = 2
    # The arity of a function describes the number of arguments which the function takes.
    assert is_function(add, 1) == false
    assert is_function(add, 2)
  end

  test "invoke an anonymous function" do
    add = fn a, b -> a + b end
    assert add.(3, 4) == 7
  end

  @doc """
  Functions are first class citizens, meaning they can be passed as arguments
  """
  test "functions using functions" do
    x = fn a, b -> a + b end
    y = fn c -> x.(c, c) end
    assert y.(2) == 4
  end
end
