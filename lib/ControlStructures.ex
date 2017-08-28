defmodule ControlStructures do
  @doc """
  'Case' is useful when you need to match against different values.

      ## Examples
      iex> ControlStructures.matchDifferentValues({1, 2, 3})
      "greetings"

      iex> ControlStructures.matchDifferentValues({2, 4})
      "ciao"

      iex> ControlStructures.matchDifferentValues({4, 5, 6, 8})
      "ooops"
  """
  def matchDifferentValues(x) do
    case x do
      {1, 2, 3} -> "greetings"
      {2, 4} -> "ciao"
      _ -> "ooops"
    end
  end

  @doc """
      ## Examples
      iex> ControlStructures.caseGuards({1, -1, 3})
      "less than"

      iex> ControlStructures.caseGuards({2, 10, 4})
      "greater than"

      iex> ControlStructures.caseGuards({1, 0, 3})
      "ooops"
  """
  def caseGuards(x) do
    case x do
      {1, y, 3} when y < 0 -> "less than"
      {2, y, 4} when y > 1 -> "greater than"
      _ -> "ooops"
    end
  end

  @doc """
  Errors in guards do not leak, but make the guard fail.

      ## Examples
      iex> ControlStructures.supressedErrors(1)
      1

      iex> ControlStructures.supressedErrors([2, 3, 4])
      "head of list"
  """
  def supressedErrors(x) do
    case x do
      x when hd(x) == 2 -> "head of list"
      x -> x
    end
  end

  @doc """
  Cond is useful when you want to check different conditions and find the first 
  condition that evaluates to true. Equivalent to else-if in many imperative
  languages.

      ## Examples
      iex> ControlStructures.conditionalMatch(1)
      "Goodbye"

      iex> ControlStructures.conditionalMatch(3)
      "Hello"

      iex> ControlStructures.conditionalMatch(4)
      "World"
  """
  def conditionalMatch(x) do
    cond do
      2 + x == 5 -> "Hello"
      2 * x == 8 -> "World"
      1 + x == 2 -> "Goodbye"
    end
  end

  @doc """
  Cond considers any value besides nil and false to be true.

      ## Examples
      iex> ControlStructures.conditionalIsTrue(nil)
      "Not true"

      iex> ControlStructures.conditionalIsTrue(false)
      "Not true"

      iex> ControlStructures.conditionalIsTrue(0)
      "So true"
  """
  def conditionalIsTrue(x) do
    cond do
      x -> "So true"

      # Equivalent to "else"
      true -> "Not true"
    end
  end

  @doc """
  If and unless are useful when you need to check for only one condition.

      ## Examples
      iex> ControlStructures.ifOneCondition(true)
      "hello"

      iex> ControlStructures.ifOneCondition(false)
      "goodbye"

      iex> ControlStructures.ifOneCondition(nil)
      "goodbye"
  """
  def ifOneCondition(x) do
    if (x) do
      "hello"
    else
      "goodbye"
    end
  end

  @doc """
      ## Examples
      iex> ControlStructures.unlessOneCondition(false)
      "goodbye"

      iex> ControlStructures.unlessOneCondition(nil)
      "goodbye"

      iex> ControlStructures.unlessOneCondition(true)
      "hello"
  """
  def unlessOneCondition(x) do
    unless (x) do
      "goodbye"
    else
      "hello"
    end
  end

  @doc """
  Control structures are wrapped in do/end blocks, but they can also be written
  as a keyword list. do/end blocks are syntactic convenience built on top of 
  the keywords list syntax.

      ## Examples
      iex> ControlStructures.doEndBlockWithKeywordListSyntax(1)
      "hello"

      iex> ControlStructures.doEndBlockWithKeywordListSyntax(0)
      "goodbye"
  """
  def doEndBlockWithKeywordListSyntax(x) do
    # this syntax is using 'keyword lists'.
    if x > 0, do: "hello", else: "goodbye"
  end

  @doc """
  This is equivalent to the do/end block above.

      ## Examples
      iex> ControlStructures.doEndBlockWithSyntacticConvenience(1)
      "hello"

      iex> ControlStructures.doEndBlockWithSyntacticConvenience(0)
      "goodbye"
  """
  def doEndBlockWithSyntacticConvenience(x) do    
    if x > 0 do
       "hello"
    else
       "goodbye"
    end
  end
  
  @doc """
  This is equivalent to the do/end block above.

      ## Examples
      iex> ControlStructures.doEndBlockAlternate(1)
      "hello"

      iex> ControlStructures.doEndBlockAlternate(0)
      "goodbye"
  """
  def doEndBlockAlternate(x) do
    if x > 0, do: (
      "hello"
    ), else: (
      "goodbye"
    )
  end

  @doc """
  do/end blocks are always bound to the outermost function call. Explicit
  parantheses can change the block binding.

      ## Examples
      iex> ControlStructures.doEndBlockOuterFunction(1)
      true

      iex> ControlStructures.doEndBlockOuterFunction(0)
      false
  """
  def doEndBlockOuterFunction(x) do
    is_number(if x > 0 do 100 else "happy" end)
  end
end