defmodule BasicTypesTest do
  use ExUnit.Case
  
  test "Basic Arithmetic" do
    assert 1 + 2 == 3
    assert 5 * 5 == 25
  end

  @doc """
  The / operator always returns a float.
  """
  test "Division" do
    assert 9 / 3 == 3.0

    # get the remainder
    assert rem(10, 3) == 1

    # integer division
    assert div(10, 3) == 3
  end

  @doc """
  Float are 64-bit double precision
  """
  test "floats support exponent number" do
    x = 1.0e-10
    assert x == 0.0000000001
  end

  test "rounding numbers" do
    x = 10 / 3
    y = Float.round(x, 4)
    assert y == 3.3333
    assert round(3.58) == 4
  end

  test "truncating a number" do
    assert trunc(3.58) == 3
  end

  test "boolean values" do
    assert is_boolean(1) == false
  end

  test "shortcut notation for binary, octal and hexadecimal numbers" do
    assert 0b1010 == 10
    assert 0o777 == 511
    assert 0x1F == 31
  end

  @doc """
  Atoms are constants where their name is the value.
  """
  test "atom equality" do
    assert :hello != :world
  end

  test "boolean values are actually atoms" do
    assert :true == true
    assert :false == false
  end  
end
