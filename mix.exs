defmodule Purlex.MixProject do
  use Mix.Project

  def project do
    [
      app: :purlex,
      version: "0.1.0",
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Purlex.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # ----- phoenix
      {:phoenix, "~> 1.4.6"},
      {:plug_cowboy, "~> 2.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      # ----- util
      {:jason, "~> 1.0"},
      {:gettext, "~> 0.11"},
      # ----- persistence
      {:persistent_ets, "~> 0.1.0"},
      # ----- development and test
      {:mix_test_watch, "~> 0.8", only: :dev}
    ]
  end
end
