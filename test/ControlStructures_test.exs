defmodule ControlStructuresTest do
  use ExUnit.Case
  doctest ControlStructures

  @doc """
  The number of arguments in each anonymous function clause needs to be the same.
  """
  test "anonymous function with multiple clauses and guards" do
    x = fn
      x, y when x > 0 -> x + y
      x, y -> x * y
      # x, y, z -> x * y + z ... will not work.
    end

    assert x.(1, 3) == 4
    assert x.(-1, 3) == -3
  end
end