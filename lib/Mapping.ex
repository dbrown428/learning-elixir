defmodule Mapping do
    def double_each([head | tail]) do
        #prepend the doubled head value to the list
        [head * 2 | double_each(tail)]
    end

    def double_each([]) do
        []
    end
end
