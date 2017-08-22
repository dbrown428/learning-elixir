defmodule NamedFunctions do
  @moduledoc """
  Groups several functions into modules. Create a module using the 'defmodule' 
  macro, and 'def' to define functions. It's convenient to write modules into 
  files so they can be compiled and reused.
  """
  
  @doc """
  ## Examples
      iex> NamedFunctions.sum(3, 4)
      7
  """
  def sum(a, b) do
    do_sum(a, b)
  end

  @doc """
  Private functions are defined with 'defp'
  """
  defp do_sum(a, b) do
    a + b
  end
end
