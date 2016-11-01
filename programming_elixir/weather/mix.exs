defmodule Weather.Mixfile do
  use Mix.Project

  def project do
    [app: :weather,
     version: "0.1.0",
     elixir: "~> 1.3",
     name: "Weather",
     source_url: "https://github.com/pragdave/issues",
     escript: escript_config,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:logger, :httpoison],
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.9.2"},
      {:sweet_xml, "~> 0.6.2"},
      {:credo, "~> 0.5.1", only: [:dev, :test]},
      {:ex_doc, "~> 0.14.3", only: [:dev]},
    ]
  end
  
  def escript_config do
    [main_module: Weather.CLI]
  end
end
