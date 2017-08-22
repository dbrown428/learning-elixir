defmodule GuardsMultipleClausesTest do
    use ExUnit.Case

    test "zero" do
        assert GuardsMultipleClauses.zero?(0) == true
    end

    @doc """
    Given an argument that does not match any of the clauses will raise an 
    error.
    """
    test "not zero float" do
        assert_raise FunctionClauseError, fn ->
            GuardsMultipleClauses.zero?(4.5)
        end
    end

    test "not zero integer" do
        assert GuardsMultipleClauses.zero?(4) == false
    end
end
