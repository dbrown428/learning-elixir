defmodule Words do
    def join(a, b \\ nil, sep \\ "_")

    def join(a, b, sep) when is_nil(b) do
        a
    end

    def join(a, b, sep) do
        a <> sep <> b
    end
end
