defmodule Maps.PatternMatching do
  @doc """
      ## Examples
      
      iex> Maps.PatternMatching.learningCases(%{:a => 1, 2 => :b})
      false

      iex> Maps.PatternMatching.learningCases(%{:c => 3})
      3

  """
  def learningCases(x) do
    case x do
      # match found
      %{:c => c} -> c

      # default
      _ -> false
    end
  end

  @doc """
  An empty map matches all maps.

      ## Examples

      iex> Maps.PatternMatching.emptyMatchesAll(%{:a => 1, 2 => :b})
      true

  """
  def emptyMatchesAll(x) do
    case x do
      %{} -> true
    end
  end

  @doc """
  Variables can be used when accessing, matching and adding key maps.
  Remember the ^ operator allows you to match against an existing variable.

  ## Examples
      
      iex> Maps.PatternMatching.variableMatching(%{4 => :one, :a => 2}, 4)
      "Match"
  """
  def variableMatching(x, y) do
    case x do
      %{^y => :one} -> "Match"
    end
  end
end
