defmodule KeywordListsTest do
  @moduledoc """
  Keyword lists are the default mechanism for passing options to functions.
  • Provide same linear performance characteristics as lists, eg. the longer
    the list, the longer it will take to find a key, count the number of
    items... etc.
  """
  use ExUnit.Case

  @doc """
  Use a tuple to represent the key-value data structure. the first item of the
  tuple (the key) is an atom. The key must be an atom.
  """
  test "keys must be atoms" do
    assert_raise ArgumentError, fn -> 
      x = [{"d", 5}]
      x["d"]
    end    
  end

  test "key values" do
    x = [{:a, 1}, {:b, 3}]
    assert x[:a] == 1
    assert x[:b] == 3
  end

  test "special syntax for defining keyword lists" do
    x = [a: 1, b: 2]
    y = [{:a, 1}, {:b, 2}]
    assert x == y
  end

  test "keys can be specified more than once" do
    x = [{:a, 3}, {:a, 6}]
    assert Keyword.get_values(x, :a) == [3, 6]
  end

  test "get first value for multiple keys" do
    x = [{:a, 3}, {:a, 6}]
    assert x[:a] == 3
  end

  @doc """
  Not the ? on the function call, I believe this means there are guards for 
  the function.
  """
  test "has a key" do
    x = [{:c, "hello"}, {:e, "world"}]
    assert Keyword.has_key?(x, :e)
  end

  test "keys are ordered as specified by the developer" do
    x = [{:a, 3}, {:c, 2}, {:b, 1}]
    assert Keyword.keys(x) == [:a, :c, :b]
  end

  test "list add" do
    x = [a: 1, b: 2]
    y = [c: 3, d: 4]
    z = x ++ y
    assert z == [a: 1, b: 2, c: 3, d: 4]
  end

  test "list append" do
    x = [a: 1, b: 2]
    y = x ++ [c: 3]
    assert y == [a: 1, b: 2, c: 3]
  end

  test "list prepend" do
    x = [a: 1, b: 2]
    y = [c: 3] ++ x
    assert y == [c: 3, a: 1, b: 2]
  end

  test "list subtract" do
    x = [a: 1, b: 2, c: 3, d: 4]
    y = x -- [b: 2, c: 3]
    assert y == [a: 1, d: 4]
  end

  test "list subtract with different elements" do
    x = [a: 1, b: 2, c: 3, d: 4]
    y = x -- [b: 2, c: 5]
    assert y == [a: 1, c: 3, d: 4]
  end

  @doc """
  In general when the keyword list is the last argument of a function,
  the square brackets are optional.
  """
  test "optional square brackets" do
    x = fn (a, b) -> a ++ b end
    y = [c: 1, d: 5, e: 0]
    z = x.(y, r: 9)
    assert z == [c: 1, d: 5, e: 0, r: 9]
  end

  @doc """
  If Macro, :do and :else are keyword lists. The following are equivalent
  statements:
  """
  test "if macro" do
    x = fn a -> if a == false, do: "this", else: "that" end
    y = fn a -> if a == false, [do: "this", else: "that"] end
    z = fn a -> if a == false, [{:do, "this"}, {:else, "that"}] end
    assert x.(true) == y.(true)
    assert x.(true) == z.(true)
  end

  @doc """
  Pattern matching is rarely done on keyword lists, because it requires the 
  number of items and their order to match.

  The following will result in a MatchError exception:
  [a: x] = [b: 2]
  [a: x] = [a: 4, b: 2]
  """
  test "pattern matching" do
    [a: x] = [a: 4]
    assert x == 4
  end
end
