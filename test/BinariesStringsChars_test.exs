defmodule BinariesStringsCharsTest do
  @moduledoc """
  A string is a UTF-8 encoded binary.
  • Unicode is a standard (https://unicode-table.com/en/) that assigns code 
    points to characters we know.

  When representing code points in bytes they need to be encoded somehow., 
  eg. UTF-8. Default encoding for Elixir is UTF-8
  """
  use ExUnit.Case

  test "byte size of utf-8 characters" do
    assert byte_size("L") == 1
    assert byte_size("ł") == 2
    assert byte_size("😀") == 4
  end

  test "compare string length and byte size" do
    x = "hełło"
    assert String.length(x) == 5
    assert byte_size(x) == 7
  end

  @doc """
  Note the ? is operating on a character and not a variable.
  """
  test "code point for a character" do
    assert ?a == 97
  end

  test "split a string into individual characters" do
    assert String.codepoints("hello") == ["h", "e", "l", "l", "o"]
  end

  @doc """
  A binary is a sequence of bytes, and the bytes can be organized in any way.
  """
  test "define a binary using <<>>" do
    x = <<0, 1, 2, 3>>
    assert byte_size(x) == 4
  end

  test "a string (binary) is a sequence of bytes organized in a specific way" do
    x = <<104, 101, 197, 130, 197, 130, 111>>
    assert String.valid? x
  end

  test "an invalid sequence of bytes for a string" do
    assert String.valid?(<<239, 191, 19>>) == false
  end

  test "a valid sequence of bytes for a string" do
    assert String.valid?(<<104, 101, 197, 130, 197, 130, 111>>)
  end

  @doc """
  Concatenate binaries using the <> operator. This is also known as the string
  concatenator.
  """
  test "string concatenator is actually a binary concatenator" do
    x = "h" <> "e" <> "l" <> "l" <> "o"
    y = <<104>> <> <<101>> <> <<108>> <> <<108>> <> <<111>>
    assert x == "hello"
    assert x == y
  end

  @doc """
  TIP: when using iex, you can concatenate a null byte to the end of the string 
  to see the inner binary representation.

  iex> "hełło" <> <<0>>
  <<104, 101, 197, 130, 197, 130, 111, 0>>
  """
  test "string charlist" do
    x = to_charlist("hełło")
    assert x == [104, 101, 322, 322, 111]
  end

  @doc """
  Binaries allow modifiers to be given to store numbers bigger than 255.
  """
  test "store numbers bigger than 255" do
    assert <<104>> == <<104>>
    assert <<256>> == <<0>>
    assert <<256 :: size(16)>> == <<1, 0>>
    assert <<256 :: utf8>> == <<196, 128>>
  end

  @doc """
  A bitstring is just a bunch of bits.
  A binary is a bitstring where the number of bits is divisible by 8.
  """
  test "a bunch of bits" do
    assert is_bitstring(<<1 :: size(1)>>)
    assert is_binary(<<1 :: size(1)>>) == false
    assert is_bitstring(<<1 :: size(8)>>)
    assert is_binary(<<1 :: size(8)>>)
  end

  test "pattern match a known size" do
    <<104, 101, x>> = <<104, 101, 111>>
    assert x == 111
  end

  test "pattern match an unknown size" do
    <<104, 101, x :: binary>> = <<104, 101, 197, 130, 197, 130, 111>>
    assert x == <<197, 130, 197, 130, 111>>
  end

  test "pattern match with the string concatenation operator" do
    "he" <> x = "hełło"
    assert x == "łło"
  end

  @doc """
  Char lists are a list of code points. Used mostly when interfacing with Erlang.
  """
  test "create char list with single-quoated literals" do
    x = 'hełło'
    y = "hełło"
    assert is_list x
    assert is_list(y) == false
  end

  test "first character in list" do
    assert List.first('hello') == 104
  end

  test "convert to string and back" do
    x = 'hełło'
    y = "hełło"
    a = to_string(x)
    b = to_charlist(y)

    assert x == b
    assert y == a
  end
end
