defmodule Mandioca.Mixfile do
  use Mix.Project

  def project do
    [app: :mandioca,
     name: "Mandioca",
     source_url: "https://github.com/matiasinsaurralde/mandioca",
     homepage_url: "http://github.com/matiasinsaurralde/mandioca",
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps,
     docs: [ extras: [ "README.md" ]]]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Mandioca, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :mongodb_ecto, :ibrowse, :instream]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.1.4"},
     {:mongodb_ecto, git: "git@github.com:michalmuskala/mongodb_ecto.git", ref: "164d1ab42670f3059370a2c290be4714faaf5761"},
     {:ecto, "1.0.0", override: true},
     {:phoenix_ecto, "~> 2.0"},
     {:phoenix_html, "~> 2.4"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.9"},
     {:cowboy, "~> 1.0"},
     {:tesla, "~> 0.2.1"},
     {:ibrowse, github: "cmullaparthi/ibrowse", ref: "b5c705c" },
     {:exjsx, "~> 3.1.0"},
     {:earmark, "~> 0.1", only: :dev},
     {:instream, "~> 0.9"},
     {:ex_doc, "~> 0.11", only: :dev}]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
