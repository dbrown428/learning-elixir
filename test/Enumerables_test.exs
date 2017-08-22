defmodule EnumerablesTest do
  @moduledoc """
  You rarely use recursion as above to manipulate lists. Use the Enum module.
  All the functions in the Enum module are eager, eg. expect an enumerable and
  return a list back.
  """
  use ExUnit.Case

  test "reduce with initial zero" do
    x = [1, 2, 3]
    initial = 0
    add = fn x, acc -> x + acc end
    y = Enum.reduce(x, initial, add)
    assert y == 6
  end

  test "reduce with initial value" do
    x = [1, 2, 3]
    initial = 10
    y = Enum.reduce(x, initial, fn(a, accumulator) -> a + accumulator end)
    assert y == 16
  end

  test "map list" do
    x = [1, 2, 3]
    double = fn a -> a * 2 end
    y = Enum.map(x, double)
    assert y == [2, 4, 6]
  end

  test "map a map" do
    x = %{1 => 9, 3 => 2}
    y = Enum.map(x, fn {a, b} -> a * b end)
    assert y == [9, 6]
  end

  test "ranges" do
    x = 1..3
    y = Enum.map(x, fn a -> a * 3 end)
    assert y == [3, 6, 9]
  end

  test "filter" do
    x = [1, 2, 3]
    y = Enum.filter(x, fn a -> rem(a, 2) != 0 end)
    assert y == [1, 3]
  end

  @doc """
  Takes output from the expression on the left side and passes it as the first
  argument to the function on the right side.
  """
  test "pipe operator" do
    x = 1..100_000
      |> Enum.map(fn a -> a * 3 end)
      |> Enum.filter(fn a -> rem(a, 2) != 0 end)
      |> Enum.sum
    assert x == 7500000000
  end
end
