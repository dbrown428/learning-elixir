defmodule Project do
  @doc """
  • projects are usually organized into three directories:
      ebin - contains the compiled bytecode
      lib - contains elixir code (usually .ex files)
      test - contains tests (usually .exs files)
  • mix will be responsible for compiling and setting up proper paths

  Scripted Mode…
  • .exs files are for scripting
  • .ex files are meant to be compiled
  • when executed, both extensions compile and load their modules into memory
  • .ex files write bytecode to disk in the format of .beam files

  """
end