defmodule Relays.Mixfile do
  use Mix.Project

  def project do
    [app: :relays,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :elixir_ale],
     mod: {Relays, []}]
  end

  defp deps do
    [
      {:elixir_ale, "~> 0.5.5"},
    ]
  end
end
