defmodule Recursion.Loop do
  @doc """
      ## Examples
      iex> Recursion.Loop.print_multiple_times("hello", 2)
      "hello\nhello"
  """
  def print_multiple_times(message, count) when count <= 1 do
    IO.puts message
  end

  def print_multiple_times(message, count) do
    IO.puts message
    print_multiple_times(message, count - 1)
  end
end
