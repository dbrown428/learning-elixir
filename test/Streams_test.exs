defmodule StreamsTest do
  @moduledoc """
  Streams are lazy; composable enumerables. Streams build a series of 
  computations that are invoked only when we pass the underlying stream 
  to the Enum module. 
  
  Streams are useful when working with large, possibly infinite, collections.
  """
  use ExUnit.Case

  @doc """
  The stream module allows us to map the range without triggering enumeration.
  """
  test "map" do
    range = 1..3
    stream = Stream.map(range, fn a -> a * 3 end)

    # No computations have been performed yet… when we enumerate over the
    # stream, then the calculations are performed.
    x = Enum.to_list(stream)
    assert x == [3, 6, 9]
  end

  test "cycle" do
    x = [1, 2, 3]
    stream = Stream.cycle(x)
    y = Enum.take(stream, 8)
    assert y == [1, 2, 3, 1, 2, 3, 1, 2]
  end

  test "unfold" do
    x = Stream.unfold("hello world", fn a -> String.next_codepoint a end)
    y = Enum.take(x, 3)
    assert y == ["h", "e", "l"]
  end

  # stream resource
  # todo
end