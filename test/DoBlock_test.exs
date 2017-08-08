defmodule DoBlockTest do
    use ExUnit.Case
    doctest DoBlock

    test "zero" do
        assert DoBlock.zero?(0) == true
    end

    test "not zero float" do
        assert DoBlock.zero?(4.5) == false
    end

    test "not zero integer" do
        assert_raise FunctionClauseError, fn ->
            DoBlock.zero?(4)
        end
    end
end
