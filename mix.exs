defmodule Linkex.MixProject do
  use Mix.Project

  def project do
    [
      app: :linkex,
      version: "0.1.0",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Linkex.Application, []},
      extra_applications: [:logger, :runtime_tools, :timex]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      # ----- phoenix backend
      {:phoenix, "~> 1.4.6"},
      {:plug_cowboy, "~> 2.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_pubsub, "~> 1.1"},
      # ----- phoenix view helpers
      {:phoenix_active_link, "~> 0.2.1"},
      {:phoenix_live_view, github: "phoenixframework/phoenix_live_view"},
      {:phoenix_ecto, "~> 4.0.0"},
      # ----- util
      {:jason, "~> 1.0"},
      {:gettext, "~> 0.11"},
      {:timex, "~> 3.1"},
      # ----- persistence
      {:pets, path: "~/src/pets"},
      # {:pets, github: "andyl/pets"},
      # ----- monitoring and tracing
      {:observer_cli, "~> 1.5"},
      # ----- development and test
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:mix_test_watch, "~> 0.8", only: :dev, runtime: false}
    ]
  end
end
