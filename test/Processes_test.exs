defmodule ProcessesTest do
  @moduledoc """
  All code runs inside processes. Processes are isolated from each other, run 
  concurrent to one another, and communicate via message passing. Processes are
  extrememly lightweight in terms of memory and CPU
  """
  use ExUnit.Case
  doctest Processes

  @doc """
  Spawn takes a function and executes it in another process and returns a 
  process identifier
  """
  test "spawn" do
    x = spawn fn -> 1 + 2 end
    assert Process.alive?(x)
  end

  test "self process" do
    x = self()
    assert Process.alive?(x)
  end
end