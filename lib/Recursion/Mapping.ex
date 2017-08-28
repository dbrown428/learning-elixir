defmodule Recursion.Mapping do
  @doc """
      ## Examples
      iex> Recursion.Mapping.double_each([1, 2, 3])
      [2, 4, 6]
  """
  def double_each([head | tail]) do
    #prepend the doubled head value to the list
    [head * 2 | double_each(tail)]
  end

  def double_each([]) do
    []
  end
end
