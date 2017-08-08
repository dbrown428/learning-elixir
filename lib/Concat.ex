defmodule Concat do
    def join(a, b, sep \\ "-") do
        # remember <> is a string concatenator
        a <> sep <> b
    end
end
