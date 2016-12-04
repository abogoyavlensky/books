defmodule Stack.Mixfile do
  use Mix.Project

  def project do
    [
      app: :stack,
      version: "0.0.1",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
    ]
  end

  def application do
    [
      mod: {Stack, []},
      env: [initial_stack: [123, "cat"]],
      registered: [:stack],
    ]
  end

  def deps do
    []
  end
end
