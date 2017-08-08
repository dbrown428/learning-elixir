defmodule GuardsMultipleClauses do
  def zero?(0) do
    true
  end

  @doc """
  The guards do not change the arity of the function.
  """
  def zero?(x) when is_integer(x) do
    false
  end
end
