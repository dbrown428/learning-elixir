defmodule FunctionCapturingTest do
  @moduledoc """
  ===============================================================================
  Function Capturing
  ===============================================================================
  • Retrieve a named function as a function type
  • the capture operator allows named functions to be assigned, passed, and 
    invoked just like anonymous functions
  • remember an anonymous function must be invoked with a dot (.)
  """
  use ExUnit.Case

  test "capture local function" do
    x = &is_number/1
    assert is_function x
  end

  @doc """
  You can capture a function from a module by specifying the fully qualified 
  name.
  """
  test "capture function from module" do
    x = &GuardsMultipleClauses.zero?/1
    assert(is_function(x))
  end

  @doc """
  By importing the zero?/1 function you don't have to use the fully qualified 
  name, eg. GuardsMultipleClauses.zero?/1
  """
  test "capture imported function" do
    import GuardsMultipleClauses, only: [zero?: 1]
    x = &zero?/1
    assert is_function x
  end
  
  @doc """
  Note the dot operator for invoking the function, just like an anonymous function.
  """
  test "invoke captured function" do
    x = &is_number/1
    y = x.("A")
    z = x.(1)
    assert y == false
    assert z == true
  end

  @doc """
  The capture syntax can also be used as a shortcut for creating functions.
  &1, &2... etc represent the arguments passed to the function.

  &(&1+1) is equivalent to fn x -> x + 1 end
  &List.flatten(&1, &2) is equivalent to fn(list, tail) -> List.flatten(list, tail) end
  """
  test "shortcut for creating functions" do
    x = &(&1 + 1)
    y = fn x -> x + 1 end

    assert is_function x
    assert x.(1) == y.(1)
  end
end
