defmodule NestedDataStructuresTest do
  use ExUnit.Case

  test "basic accessing of data" do
    x = [
      john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
      mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
    ]

    assert x[:john].age == 27
    assert length(x[:mary].languages) == 3
    assert length(x) == 2
  end

  test "put a value into the data" do
    x = [
      john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
      mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
    ]

    y = put_in x[:john].age, 31
    assert x != y
    assert y[:john].age == 31
  end

  test "update a value in the data" do
    x = [
      john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
      mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
    ]

    y = update_in x[:mary].languages, fn languages -> List.delete(languages, "Clojure") end
    assert x != y
    assert length(y[:mary].languages) == 2
  end

  test "get and update a value in the data" do
    x = [
      john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
      mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
    ]

    # TODO
    assert false
    # y = get_and_update_in(x[:john].age, fn age -> {x[:john].age, age + 3} end)
    # assert x != y
    # assert y[:john].age == 30
  end
end
