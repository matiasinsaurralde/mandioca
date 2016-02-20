defmodule SimplePlug.Mixfile do
  use Mix.Project

  def project do
    [app: :simple_plug,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :ibrowse],
     mod: {SimplePlug, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.1.0"},
      {:tesla, "~> 0.2.1"},
      # {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.2.2"}, # default adapter
      {:ibrowse, github: "cmullaparthi/ibrowse", ref: "b5c705c" },
      {:exjsx, "~> 3.1.0"} # for JSON middleware
    ]
  end
end
