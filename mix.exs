defmodule Learning.Mixfile do
  use Mix.Project

  @doc """
  Mix makes a distinction between projects and applications. Mix manages your
  project. Some projects don't define any application.
  """
  def project do
    [
      app: :learning,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  @doc """
  Applications are entities that are started and stopped as a whole by the runtime.
  OTP.

  Run "mix help compile.app" to learn about applications.
  """
  def application do
    [
      extra_applications: [:logger],
      
      # mod specifies the application callback module - it can be any module
      # that implements Application behaviour.
      mod: {KV, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
