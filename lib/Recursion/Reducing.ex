defmodule Recursion.Reducing do
  @doc """
      ## Examples
      iex> Recursion.Reducing.sum_list([1, 2, 3], 0)
      6
  """
  def sum_list([head | tail], accumulator) do
    sum_list(tail, head + accumulator)
  end

  def sum_list([], accumulator) do
    accumulator
  end
end
