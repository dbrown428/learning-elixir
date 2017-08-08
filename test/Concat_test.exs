defmodule ConcatTest do
    use ExUnit.Case
    doctest Concat

    test "default seperator" do
        assert Concat.join("hello", "world") == "hello-world"
    end

    test "custom separator" do
        assert Concat.join("hello", "world", "+") == "hello+world"
    end
end
