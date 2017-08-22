defmodule StringTest do
  use ExUnit.Case

  @doc """
  Strings are inserted between double quotes and are encoded in UTF8.
  """
  test "string length and size" do
    x = "hellö"
    assert String.length(x) == 5
    assert byte_size(x) == 6
  end

  @doc """
  Strings in Elixir are represented internally by binaries which are sequences of bytes.
  """
  test "is binary" do
    x = "hellö"
    assert is_binary(x)
  end

  test "string interpolation" do
    assert "hello #{:world}" == "hello world"
  end

  test "strings can have line breaks in them" do
    x = "hello

world"
    assert x == "hello\n\nworld"
  end

  @doc """
  Leading and trailing whitespace are ignored and trimmed.
  """
  test "split string on whitespace occurence" do
    x = String.split("   greetings earth   people ")
    assert x == ["greetings", "earth", "people"]
  end

  test "spliting a string with a pattern" do
    x = String.split("foo-bar", "-")
    assert x == ["foo", "bar"]
  end

  test "split a string with options" do
    x = String.split("   greetings earth   people ", " ", [parts: 2, trim: true])
    assert x == ["greetings", "earth   people "]
  end

  test "split a string with a regular expression" do
    x = String.split("abc", ~r{b}, include_captures: true)
    assert x == ["a", "b", "c"]
  end

  test "split a string a specified offset" do
    x = String.split_at("helloworld", 5)
    assert x == {"hello", "world"}
  end

  test "split a string on demand" do
    x = String.splitter("1,2 3,4 5,6 7,8,...,99999", [",", " "]) |> Enum.take(4)
    assert x == ["1", "2", "3", "4"]
  end

  test "slicing strings" do
    x = String.slice("foo bar", 4..6)
    assert x == "bar"

    y = String.slice("foo bar", 0, 3)
    assert y == "foo"
  end

  test "string case" do
    x = String.upcase("hello")
    assert x == "HELLO"

    y = String.capitalize("world")
    assert y == "World"

    z = String.downcase(x)
    assert z == "hello"
  end

  test "duplicate a string" do
    x = String.duplicate("hello", 3)
    assert x == "hellohellohello"
  end

  test "string ends with" do
    assert String.ends_with?("hello world", ["!", "ld"]) == true
  end
end