defmodule DefaultArguments do
  @moduledoc """
  ===============================================================================
  Default Arguments
  ===============================================================================
  • Named functions support default arguments using: \\
  • Default values are only evaluated if they have to be used.
  """

  @doc """
  If a function has multiple clauses, it is required to create a function head 
  without an actual body.

  You should define all the defaults in the function header.
  """
  def join(a, b \\ nil, separator \\ "-")

  @doc ~S"""
  Be cautious of function definition order with default values.
  Notice how this clause is more specific than the following clause.

  ## Examples

      iex> DefaultArguments.join("Hello")
      "Hello"
      
  Note the leading underscore for separator tells the compiler that we know 
  this variable is not used and we don't need to be warned.
  """
  def join(a, b, _separator) when is_nil(b) do
    a
  end

  @doc ~S"""
  • Remember <> is a string concatenator.
  
  ## Examples

      iex> DefaultArguments.join("Hello", "World")
      "Hello-World"

      iex> DefaultArguments.join("Hello", "World", "+")
      "Hello+World"

  """
  def join(a, b, separator) do
    a <> separator <> b
  end
end
