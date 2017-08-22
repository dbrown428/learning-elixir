defmodule Tuples do
  use ExUnit.Case

  @doc """
  Tuples can hold any value. Accessing a tuple element by index or getting the 
  tuple size is a fast operation.
  """
  test "tuples" do
    x = {:hello, "world"}
    y = {"hello", 2, [world: 4]}
    assert x != y
    assert tuple_size(x) == 2
    assert tuple_size(y) == 3
  end

  @doc """
  Tuples are not meant to be used as a collection type. Mostly used as a
  fixed container size for multiple elements.
  """
  test "accessing elements" do
    x = {4, "hello", :world}
    assert elem(x, 1) == "hello"
  end

  test "accessing an element that does not exist" do
    x = {"hello", 5}
    assert_raise ArgumentError, fn -> 
      elem(x, 2)
    end
  end

  @doc """
  Updating or adding elements is expensive because it requires copying the 
  whole tuple in memory.
  """
  test "replacing element" do
    x = {4, "hello", :world}
    y = put_elem(x, 1, "goodbye")
    assert y == {4, "goodbye", :world}
    assert x != y
  end

  test "insert into" do
    x = {3, 4, 5}
    y = Tuple.insert_at(x, 0, 2)
    assert y == {2, 3, 4, 5}

    z = Tuple.insert_at(x, 1, 3.5)
    assert z == {3, 3.5, 4, 5}
  end

  test "append element" do
    x = {4, "hello", :world}
    y = Tuple.append(x, "greetings")
    assert x != y
    assert y == {4, "hello", :world, "greetings"}
  end

  test "delete at" do
    x = {4, "hello", :world}
    y = Tuple.delete_at(x, 0)
    assert y == {"hello", :world}
  end

  test "duplicate once" do
    x = {9, 4, :great}
    y = Tuple.duplicate(x, 3)
    assert y == {{9, 4, :great}, {9, 4, :great}, {9, 4, :great}}
  end

  test "to list" do
    x = {9, "hello", :world}
    y = Tuple.to_list(x)
    assert y == [9, "hello", :world]
  end
end
