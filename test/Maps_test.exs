defmodule MapsTest do
  @moduledoc """
  ===============================================================================
  Maps
  ===============================================================================
  • The go to data structure.
  • Allow any value as a key.
  • Does not follow any ordering.
  • Very helpful with pattern matching.
  • Created using the %{} syntax
  """
  use ExUnit.Case
  doctest Maps.PatternMatching
  doctest Maps.Manipulating

  test "map creation" do
    x = %{:a => 1, 2 => :b}
    assert x[:a] == 1
    assert x[2] == :b
    assert x[:c] == nil
  end

  @doc """
  The pattern matching will always match on a subset of the given value.
  """
  test "pattern match a subset of a given value" do
    x = %{:a => 1, 2 => :b}
    %{:a => a} = x
    assert a == 1
  end

  test "get a value from a map" do
    x = %{:a => 1, 2 => :b}
    assert Map.get(x, :a) == 1
  end

  test "put a value into a map" do
    x = %{:a => 1, 2 => :b}
    y = Map.put(x, :c, 3)
    assert y == %{:a => 1, 2 => :b, :c => 3}
  end

  @doc """
  Not the order of the resulting list; the elements are ordered by they keys,
  with integers first, atoms next, and lastly string keys.
  """
  test "map to list" do
    x = %{
      :a => 1, 
      2 => :b, 
      :e => 9, 
      1 => "hello", 
      :c => "world",
      "y" => "day",
      "x" => "happy",
    }
    y = Map.to_list x
    assert y == [
      {1, "hello"},
      {2, :b}, 
      {:a, 1},
      {:c, "world"},
      {:e, 9},
      {"x", "happy"},
      {"y", "day"},
    ]
  end

  test "update a key value" do
    x = %{3 => "hello", :p => "world"}
    y = %{x | :p => "kelowna"}
    assert y == %{3 => "hello", :p => "kelowna"}
  end

  test "do not use | to add new keys" do
    x = %{"a" => 4, "b" => 6}
    assert_raise KeyError, fn ->
      %{x | "c" => 8}
    end    
  end

  @doc """
  Prefer the map.<field> syntax and pattern matching instead of functions in 
  the Map module.
  """
  test "accessing atom keys" do
    x = %{:t => "hello world", :ok => "test"}
    assert x.ok == "test"
  end
end
