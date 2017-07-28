defmodule DoBlock do
    def zero?(0), do: true
    def zero?(x) when is_float(x), do: false
end
