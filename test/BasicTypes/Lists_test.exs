defmodule ListsTest do
  use ExUnit.Case
  
  @doc """
  Appending items to the list is slow, as the entire list needs to be traversed.
  """
  test "concatenate linked lists" do
    x = ["1", "2", "3"]
    y = ["4", "5", "6"]
    z = x ++ y
    assert z == ["1", "2", "3", "4", "5", "6"]
  end

  test "subtract linked lists" do
    x = ["1", "2", "3"]
    y = ["1", "3"]
    z = x -- y
    assert z == ["2"]
  end

  test "head of linked list" do
    x = ["1", "2", "3"]
    assert hd(x) == "1"
  end

  test "tail of linked list" do
    x = ["1", "2", "3"]
    assert tl(x) == ["2", "3"]
  end

  @doc """
  Prepending items to a list is fast, as the list does not need to be
  traversed.
  """
  test "prepend items to list" do
    x = [1, 2, 3]
    y = [0 | x]
    assert y == [0, 1, 2, 3]
  end

  @doc """
  We need to traverse the whole list in order to figure out its size. 
  Updating a list is fast as long as we are prepending elements. 
  Calculating the length gets slower as the input grows.

  If an operation is named "size" then it is a constant time (ie. pre-computed
  value).

  If an operation is named "length" then it is linear (ie. gets slower as input
  grows).
  """
  test "length is a linear operation" do
    x = [0, 1, 2, 3]
    assert length(x) == 4
  end
end
